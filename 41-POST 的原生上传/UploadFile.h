//
//  UploadFile.h
//  41-POST 的原生上传
//
//  Created by Mac on 14-11-9.
//  Copyright (c) 2014年 MN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadFile : NSObject
-(void)uploadFileWithURL:(NSURL *)url data:(NSData *)data;
@end
