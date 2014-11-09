//
//  UploadFile.m
//  41-POST 的原生上传
//
//  Created by Mac on 14-11-9.
//  Copyright (c) 2014年 MN. All rights reserved.
//

#import "UploadFile.h"

@implementation UploadFile


static NSString *boundaryStr = @"--";   // 分隔字符串
static NSString *randomIDStr;           // 本次上传标示字符串
static NSString *uploadID;              // 上传(php)脚本中，接收文件字段

- (instancetype)init
{
    self = [super init];
    if (self) {
        randomIDStr = @"mn";
        uploadID = @"uploadFile";
    }
    return self;
}


- (NSString *)topStringWithMimeType:(NSString *)mimeType uploadFile:(NSString *)uploadFile
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"%@%@\n", boundaryStr, randomIDStr];
    [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\n", uploadID, uploadFile];
    [strM appendFormat:@"Content-Type: %@\n\n", mimeType];
    
    NSLog(@"%@", strM);
    return [strM copy];
}

- (NSString *)bottomString
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"%@%@\n", boundaryStr, randomIDStr];
    [strM appendString:@"Content-Disposition: form-data; name=\"submit\"\n\n"];
    [strM appendString:@"Submit\n"];
    [strM appendFormat:@"%@%@--\n", boundaryStr, randomIDStr];
    
    NSLog(@"%@", strM);
    return [strM copy];
}
-(void)uploadFileWithURL:(NSURL *)url data:(NSData *)data
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:2.0f];
    
    
    // 2.设置数据体
    NSMutableData *dataM = [[NSMutableData alloc] init];
    NSString *bottom = [self bottomString];
    NSString *top = [self topStringWithMimeType:@"image/png" uploadFile:@"小涵.png"];
    
    [dataM appendData:[top dataUsingEncoding:NSUTF8StringEncoding]];
    [dataM appendData:data];
    [dataM appendData:[bottom dataUsingEncoding:NSUTF8StringEncoding]];
    request.HTTPBody = dataM;
    request.HTTPMethod = @"POST";
    
    // 1.设置头信息
    [request setValue: [NSString stringWithFormat:@"%ld",(long)dataM.length] forHTTPHeaderField:@"Content-Length"];
    NSString *CT = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",randomIDStr];
    
    [request setValue:CT forHTTPHeaderField:@"Content-Type"];

    // 3.连接服务器
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
        
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",result);
      }];
}


@end
