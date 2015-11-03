//
//  ViewController.m
//  YouMinDemo
//
//  Created by panda zheng on 11/1/15.
//  Copyright © 2015 pandazheng. All rights reserved.
//

#import "ViewController.h"
#import <dlfcn.h>
#import <mach/port.h>
#import <mach/kern_return.h>
#import <sys/sysctl.h>

@interface ViewController ()

@end

@implementation ViewController

- (void) getInfo {
    //手机序列号
    NSString *identifierNumber = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSLog(@"手机UUID:%@",identifierNumber);
    
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
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    NSLog(@"rect.size.width = %f,rect.size.height = %f",rect.size.width,rect.size.height);
}

- (NSString *) getMachine {
    size_t size;
    sysctlbyname("hw.machine",NULL,&size,NULL,0);
    char *name = malloc(size);
    sysctlbyname("hw.machine", name, &size, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
    free(name);
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 GSM";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6 GSM+CDMA";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6+ GSM";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6+ Global";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (GSM)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina (GSM)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    
    return platform;
}

- (NSString *) serialNumber {
    NSString *serialNumber = nil;
    
    void *IOKit = dlopen("/System/Library/Frameworks/IOKit.framework/IOKit", RTLD_NOW);
    if (IOKit)
    {
        mach_port_t *kIOMasterPortDefault = dlsym(IOKit, "kIOMasterPortDefault");
        CFMutableDictionaryRef (*IOServiceMatching)(const char *name) = dlsym(IOKit, "IOServiceMatching");
        mach_port_t (*IOServiceGetMatchingService)(mach_port_t masterPort, CFDictionaryRef matching) = dlsym(IOKit, "IOServiceGetMatchingService");
        CFTypeRef (*IORegistryEntryCreateCFProperty)(mach_port_t entry, CFStringRef key, CFAllocatorRef allocator, uint32_t options) = dlsym(IOKit, "IORegistryEntryCreateCFProperty");
        kern_return_t (*IOObjectRelease)(mach_port_t object) = dlsym(IOKit, "IOObjectRelease");
        
        if (kIOMasterPortDefault && IOServiceGetMatchingService && IORegistryEntryCreateCFProperty && IOObjectRelease)
        {
            mach_port_t platformExpertDevice = IOServiceGetMatchingService(*kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice"));
            if (platformExpertDevice)
            {
                CFTypeRef platformSerialNumber = IORegistryEntryCreateCFProperty(platformExpertDevice, CFSTR("IOPlatformSerialNumber"), kCFAllocatorDefault, 0);
                if (platformSerialNumber && CFGetTypeID(platformSerialNumber) == CFStringGetTypeID())
                {
                    serialNumber = [NSString stringWithString:(__bridge NSString *)platformSerialNumber];
                    CFRelease(platformSerialNumber);
                }
                IOObjectRelease(platformExpertDevice);
            }
        }
        dlclose(IOKit);
    }
    //NSLog(@"手机序列号:%@",serialNumber);
    
    return serialNumber;
}

- (void) getserialNumber {
    NSBundle *b = [NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/AppleAccount.framework"];
    BOOL success = [b load];
    NSLog(@"AppleAccount Load: %hhd",success);
    
    Class AADeviceInfo = NSClassFromString(@"AADeviceInfo");
    NSLog(@"AADeviceInfo=%@",AADeviceInfo);
    
    //NSLog(@"-- serialNumber: %@", [AADeviceInfo serialNumber]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self getInfo];
    [self serialNumber];
    [self getserialNumber];
    
    NSString *platform = [self getMachine];
    NSLog(@"手机型号:%@",platform);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
