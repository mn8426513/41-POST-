//
//  ViewController.m
//  41-POST 的原生上传
//
//  Created by Mac on 14-11-9.
//  Copyright (c) 2014年 MN. All rights reserved.
//

#import "ViewController.h"
#import "UploadFile.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UploadFile *upload = [[UploadFile alloc] init];
    
    NSString *path = [NSString stringWithFormat:@"http://localhost/upload.php"];
    
    
    //这种方法只适合上传小于2MB的东西
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"小涵.jpg" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    [upload uploadFileWithURL:[NSURL URLWithString:path] data:data];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
