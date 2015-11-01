//
//  ViewController.m
//  YouMinDemo
//
//  Created by panda zheng on 11/1/15.
//  Copyright © 2015 pandazheng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void) getInfo {
    NSLog(@"getinfo begin......\n");
    
    //手机序列号
    NSString *identifierNumber = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSLog(@"手机序列号:%@",identifierNumber);
    
    //手机别名：用户定义的名称
    NSString *userPhoneName = [[UIDevice currentDevice] name];
    NSLog(@"手机别名:%@",userPhoneName);
    
    //设备名称
    NSString *deviceName = [[UIDevice currentDevice] systemName];
    NSLog(@"设备名称:%@",deviceName);
    
    //手机系统版本
    NSString *phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"手机系统版本:%@",phoneVersion);
    
    //手机型号
    NSString *phoneModel = [[UIDevice currentDevice] model];
    NSLog(@"手机型号:%@",phoneModel);
    
    //地方型号
    NSString *localPhoneModel = [[UIDevice currentDevice] localizedModel];
    NSLog(@"国际化区域名称:%@",localPhoneModel);
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //当前应用名称
    NSString *appCurName = [infoDictionary objectForKey:@"CFBundleName"];
    NSLog(@"当前应用名称:%@",appCurName);
    //当前应用软件版本
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前应用软件版本:%@",appCurVersion);
    //当前应用版本号码
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSLog(@"当前应用版本号码:%@",appCurVersionNum);
}

- (NSString *) serialNumber {
    NSString *serialNumber = nil;
    
    
    return serialNumber;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self getInfo];
    [self serialNumber];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
