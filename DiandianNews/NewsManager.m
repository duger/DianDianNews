//
//  NewsManager.m
//  DiandianNews
//
//  Created by Duger on 13-12-5.
//  Copyright (c) 2013年 Duger. All rights reserved.
//
#define kNewsPlist @"news.plist"
#define kNewsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingString:@"/News"]
#define kColumnDoucmentPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingString:@"/Columns"]
#define kColumnPath [[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingString:@"/Columns"]stringByAppendingPathComponent:@"Columns.plist"]
#define kLenge 16
#define kLastUpdate @"lastUpdate"

#define kURLStr @"http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx?startRecord=%d&len=%d&udid=1234567890&cid=%d"
#define kNewsUrl "http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx"
#define kNewsPlistPath [kNewsPath stringByAppendingPathComponent:kNewsPlist]
#define kNewsStep 9


#import "NewsManager.h"
#import "NSArray+Additon.h"

@interface NewsManager ()
//更新栏目更新时间
-(void)_updateColumnUpdateTime:(NSTimeInterval)time andColumn:(ColumnIndex)column;
//同步请求
-(void)_httpSynchronousRequest:(NSInteger)cId;

@end



@implementation NewsManager
static NewsManager *s_NewManager = nil;
+(NewsManager *)defaultManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (s_NewManager == nil) {
            s_NewManager = [[self alloc]init];
        }
    });
    return s_NewManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.selectedColumns = [[NSMutableArray alloc]init];
        self.startRecord = 0;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeColumn:) name:@"columnChanged" object:nil];
    }
    return self;
}

- (void)dealloc
{
    self.selectedColumns = nil;
    self.newsArr = nil;
    self.delegate = nil;
    [super dealloc];
}

-(void)changeColumn:(id)sender
{
    NSLog(@"%@",sender);
    NSDictionary *column = [sender userInfo];
    
    NSLog(@"%@",[column description]);
    [self _updateColumn:column];
}

-(void)setUp
{
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"existedColumn"]) {
        //设置背景颜色
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"nightOrDay"];
        //将Columns.plist复制到Document/Column
        NSArray *columnArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Columns" ofType:@"plist"]];
        NSLog(@"%@",kColumnPath);
        [[NSFileManager defaultManager]createDirectoryAtPath:kColumnDoucmentPath withIntermediateDirectories:NO attributes:nil error:nil];
        [columnArr writeToFile:kColumnPath atomically:YES];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"existedColumn"];
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSArray *columnDicArr = [self getColumnDicFromPlist];
    for (NSDictionary *columnDic in columnDicArr) {
        dispatch_async(queue, ^{
            NSInteger columnIndex = [[columnDic objectForKey:@"cId"]integerValue];
            
            NSTimeInterval time = [((NSNumber *)[columnDic objectForKey:@"lastUpdate"])doubleValue];
            NSLog(@"%f",time);
            NSTimeInterval currentTime = [[NSDate date]timeIntervalSince1970];
            NSLog(@"%.f",currentTime);
            if (currentTime - time > 9800.0) {
                [self _httpSynchronousRequest:columnIndex];
            }
            
        });
    }
}

//同步请求
-(void)_httpSynchronousRequest:(NSInteger)cId
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kURLStr,self.startRecord,kLenge,cId]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:2.0];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
    NSLog(@"%d",responseCode);
    NSDictionary *resultDic = nil;
    if (error == nil && responseCode == 200) {
        resultDic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        NSArray *newsArr = [resultDic objectForKey:@"news"];
        NSTimeInterval updateTime = [((NSNumber *)[resultDic objectForKey:@"lastUpdateTime"])doubleValue];
        [self writeIntoNewsPlist:newsArr andColumn:cId];
        [self _updateColumnUpdateTime:updateTime andColumn:cId];
    }
    
}


#pragma mark URLRequest
-(void)updateNews:(ColumnIndex)column
{
    self.currentColumn = column;
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kURLStr,self.startRecord,kLenge,column]];
    NSLog(@"%@",url);
    NewURLRequest *newsRequest = [[NewURLRequest alloc]init];
    newsRequest.delegate = self;
    [newsRequest webRequest: url];
    [newsRequest release];
}

#pragma mark NewURLRequest delegate
-(void)compliteRequestWithDic:(NSDictionary *)resultDic
{
    self.newsArr = [resultDic objectForKey:@"news"];
    NSTimeInterval updateTime = [((NSNumber *)[resultDic objectForKey:@"lastUpdateTime"])doubleValue];
    NSLog(@"%f",updateTime);
    
    [self writeIntoNewsPlist:self.newsArr andColumn:self.currentColumn];
    [self _updateColumnUpdateTime:updateTime andColumn:self.currentColumn];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreashNow" object:nil];
    
}
-(void)compliteRequestWithError:(NSError *)error
{
    NSLog(@"出错了！！%@",error);
}

#pragma mark -
#pragma mark Column
//获得已经选择好的栏目
-(NSArray *)getColumnsSelected
{
    NSString *path = kColumnPath;
    NSArray *columnsArr = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *selectedClolumns = [[NSMutableArray alloc]init];
    for (NSDictionary *columnDic in columnsArr) {
        if ([[columnDic objectForKey:@"selected"]isEqualToString:@"1"]) {
            NSLog(@"%@",[columnDic objectForKey:@"selected"]);
            NSLog(@"%@",[columnDic objectForKey:@"column"]);
            [selectedClolumns addObject:[columnDic objectForKey:@"column"]];
        }
    }
    
    return [selectedClolumns autorelease];
}

//获取所有选择好的栏目字典
-(NSArray *)getColumnDicFromPlist
{
    NSString *path = kColumnPath;
    NSArray *columnsArr = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *selectedClolumns = [[NSMutableArray alloc]init];
    for (NSDictionary *columnDic in columnsArr) {
        if ([[columnDic objectForKey:@"selected"]isEqualToString:@"1"]) {
            NSLog(@"%@",[columnDic objectForKey:@"selected"]);
            NSLog(@"%@",[columnDic objectForKey:@"column"]);
            [selectedClolumns addObject:columnDic];
        }
    }
    return [selectedClolumns autorelease];
    
}

//获取所有的栏目字典
-(NSArray *)getAllColumnDicFromPlist
{
    NSString *path = kColumnPath;
    NSArray *columnsArr = [NSArray arrayWithContentsOfFile:path];
    
    return columnsArr;
    
}


-(void)_updateColumnUpdateTime:(NSTimeInterval)time andColumn:(ColumnIndex)column
{
    NSArray *selectedColumns = [self getAllColumnDicFromPlist];
    NSMutableArray *resultArr = [[NSMutableArray alloc]init];
    for (NSDictionary *item in selectedColumns) {
        if ([[item objectForKey:@"cId"]isEqualToString:[NSString stringWithFormat:@"%d",column]]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:item];
            [dic setValue:[NSNumber numberWithDouble:time] forKey:@"lastUpdate"];
            
            [resultArr addObject:dic];
        }else
            [resultArr addObject:item];
    }
    NSLog(@"%@",resultArr);
    [resultArr writeToFile:kColumnPath atomically:YES];
    
}

-(void)_updateColumn:(NSDictionary *)column
{
    NSMutableArray *selectedColumns =[NSMutableArray arrayWithArray:[self getAllColumnDicFromPlist]];
    NSLog(@"%@",[column objectForKey:@"cId"]);
    NSMutableArray *resultArr = [[NSMutableArray alloc]init];
    for (NSDictionary *item in selectedColumns) {
        if ([[column objectForKey:@"cId"]isEqualToString:[item objectForKey:@"cId"]]) {
            [resultArr addObject:column];
        }else
        [resultArr addObject:item];
    }
    [resultArr writeToFile:kColumnPath atomically:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeColumns" object:nil];
}


#pragma mark -
#pragma mark  News Plist
-(BOOL)isNewsPlistExist
{
    NSString *newsPath = [kNewsPath stringByAppendingPathComponent:kNewsPlist];
    BOOL isDictionary;
    //判断对应路径是否存在该文件夹，如果不存在则新建文件夹
    if (![[NSFileManager defaultManager]fileExistsAtPath:kNewsPath]) {
        [[NSFileManager defaultManager]createDirectoryAtPath:kNewsPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:newsPath isDirectory:&isDictionary]) {
        return YES;
    }else{
        return NO;
    }
}

-(void)writeIntoNewsPlist:(NSArray *)array
{
    self.lastUpdate = NSTimeIntervalSince1970;
    [array writeToFile:kNewsPlistPath atomically:YES completed:^{
        [self.delegate didFinishWritePlist];
    }];
}

-(void)writeIntoNewsPlist:(NSArray *)array andColumn:(NSInteger )column
{
    NSLog(@"%d-----%@",column,[array description]);
    NSMutableDictionary *dic;
    if ([self isNewsPlistExist]) {
        dic = [[NSMutableDictionary alloc]initWithContentsOfFile:kNewsPlistPath];
        
    }else{
        dic = [[NSMutableDictionary alloc]init];
    }
    if (![[dic allKeys]containsObject:[NSString stringWithFormat:@"%d",column]]) {
        
        [dic setObject:array forKey:[NSString stringWithFormat:@"%d",column]];
        
        self.lastUpdate = [NSDate timeIntervalSinceReferenceDate];
        [dic writeToFile:kNewsPlistPath atomically:YES];
        
    }else{
        [dic removeObjectForKey:[NSString stringWithFormat:@"%d",column]];
        [dic setObject:array forKey:[NSString stringWithFormat:@"%d",column]];
        self.lastUpdate = [NSDate timeIntervalSinceReferenceDate];
        [dic writeToFile:kNewsPlistPath atomically:YES];
    }
    [dic release];
    
}

-(NSArray *)readFromNewsPlist:(ColumnIndex)column
{
    
    
    
    NSDictionary *resultDic = [[NSDictionary alloc]initWithContentsOfFile:kNewsPlistPath];
    NSArray *newsArr = [resultDic objectForKey:[[NSNumber numberWithInteger:column]stringValue]];
    
    
    return [newsArr autorelease];
    
    
}


-(void)downloadNewsToPlist:(NSArray *)newsArr andColumn:(ColumnIndex)column
{
    if (![newsArr count]) {
        return;
    }
    
    __block BOOL isChanged = NO;
    NSMutableArray *tempNewsArr = [NSMutableArray arrayWithArray:newsArr];
    //    NSMutableArray *tempNewsArr = [newsArr mutableCopy];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    for (int i = 0; i < [tempNewsArr count]; i++) {
        NSMutableDictionary *news = [tempNewsArr objectAtIndex:i];
        
        if (![news objectForKey:@"newsHtml"]) {
            isChanged = YES;
            dispatch_group_async(group,queue, ^{
                NSString *urlString = [news objectForKey:@"newsUrl"];
                NSString *html = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil];
                html = [html stringByReplacingOccurrencesOfString:@"<link href=\"../../../Styles/RBstyle_phone.css\" rel=\"stylesheet\" type=\"text/css\" />" withString:@"<link href=\"RBstyle_phone.css\" rel=\"stylesheet\" type=\"text/css\" />"];
                html = [html stringByReplacingOccurrencesOfString:@"<link href=\"../../../Styles/bwxsj.css\" rel=\"stylesheet\" type=\"text/css\" />" withString:@"<link href=\"bwxsj.css\" rel=\"stylesheet\" type=\"text/css\" />"];
                html = [html stringByReplacingOccurrencesOfString:@"../../.." withString:@"http://ipad-bjwb.bjd.com.cn/DigitalPublication"];
                [news setValue:html forKey:@"newsHtml"];
                [tempNewsArr replaceObjectAtIndex:i withObject:news];
                
            });
        }
        
    }
    dispatch_group_notify(group, queue, ^{
        if (isChanged) {
            [self writeIntoNewsPlist:[tempNewsArr mutableCopy] andColumn:column];
            
            
        }
        
    });
    dispatch_release(group);
}



@end
