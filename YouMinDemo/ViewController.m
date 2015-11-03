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
#import <sys/utsname.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#include <netdb.h>
#import "UIDevice-Hardware.h"


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

- (NSString *) deviceName {
    struct utsname systeminfo;
    uname(&systeminfo);
    
    return [NSString stringWithCString:systeminfo.machine encoding:NSUTF8StringEncoding];
}

- (NSString *) routerIp {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    NSString *wifiIP;
    NSString *wifiBroadcastAddress;
    NSString *wifiNetMast;
    NSString *wifiInterface;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String //ifa_addr
                    //ifa->ifa_dstaddr is the broadcast address, which explains the "255's"
                    //                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr)];
                    
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                    //routerIP----192.168.1.255 广播地址
                    NSLog(@"broadcast address--%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr)]);
                    wifiBroadcastAddress = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr)];
                    
                    //--192.168.1.106 本机地址
                    NSLog(@"local device ip--%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]);
                    wifiIP = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                    //--255.255.255.0 子网掩码地址
                    NSLog(@"netmask--%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr)]);
                    wifiNetMast = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr)];
                    
                    //--en0 端口地址
                    NSLog(@"interface--%@",[NSString stringWithUTF8String:temp_addr->ifa_name]);
                    wifiInterface = [NSString stringWithUTF8String:temp_addr->ifa_name];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}

- (void) defaultGateWay {
    NSString *routerIp = [self routerIp];
    NSLog(@"local device ip address:%@",routerIp);
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

- (void) getBatteryInfo {
    //电池的状态是可监听的
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    //电池的状态
    switch ([UIDevice currentDevice].batteryState) {
        case UIDeviceBatteryStateUnknown:
            NSLog(@"电池的状态未知");
            break;
        case UIDeviceBatteryStateCharging:
            NSLog(@"电池正在充电");
            break;
        case UIDeviceBatteryStateUnplugged:
            NSLog(@"电池未充电");
            break;
        case UIDeviceBatteryStateFull:
            NSLog(@"电池电量充满");
            break;
        default:
            break;
    }
    
    //获取当前电池的电量
    NSLog(@"当前电池的电量百分比是%3.0f%%",([[UIDevice currentDevice] batteryLevel])*100);
}

- (void) getIphoneDeviceInfo {
    UIDevice *device = [UIDevice currentDevice];
    //平台型号
    NSLog(@"平台型号:%@",[device platformString]);
    //cpu型号
    NSLog(@"cpu型号:%@",[device cpuType]);
    //cpu频率
    NSLog(@"cpu频率:%@",[device cpuFrequency]);
    //cpu核数
    NSLog(@"%@",[NSString stringWithFormat:@"cpu核数:%u",[device cpuCount]]);
    //cpu使用率
    NSLog(@"%@",[NSString stringWithFormat:@"cpu使用率:%@",[device cpuUsage]]);
    //手机总内存
    NSLog(@"%@",[NSString stringWithFormat:@"手机总内存:%u",[device totalMemoryBytes] / (1024)]);
    //可用内存
    NSLog(@"%@",[NSString stringWithFormat:@"手机可用内存:%u",[device freeMemoryBytes] / (1024)]);
    //磁盘总空间
    NSLog(@"%@",[NSString stringWithFormat:@"手机磁盘总空间:%lld",[device totalDiskSpaceBytes] / (1024)]);
    //可用硬盘空间
    NSLog(@"%@",[NSString stringWithFormat:@"手机可用硬盘空间:%lld",[device freeDiskSpaceBytes] / (1024)]);
    //是否支持蓝牙
    NSLog(@"%@",[NSString stringWithFormat:@"手机是否支持蓝牙:%hhd",[device bluetoothCheck]]);
    //手机是否越狱
    NSLog(@"%@",[NSString stringWithFormat:@"手机是否越狱:%hhd",[device isJailBreak]]);
}

//-(NSString *) macaddress
//{
//    int                 mgmtInfoBase[6];
//    char                *msgBuffer = NULL;
//    size_t              length;
//    unsigned char       macAddress[6];
//    struct if_msghdr    *interfaceMsgStruct;
//    struct sockaddr_dl  *socketStruct;
//    NSString            *errorFlag = NULL;
//    
//    // Setup the management Information Base (mib)
//    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
//    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
//    mgmtInfoBase[2] = 0;
//    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
//    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
//    
//    // With all configured interfaces requested, get handle index
//    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
//        errorFlag = @"if_nametoindex failure";
//    else
//    {
//        // Get the size of the data available (store in len)
//        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
//            errorFlag = @"sysctl mgmtInfoBase failure";
//        else
//        {
//            // Alloc memory based on above call
//            msgBuffer =(char*) malloc(length) ;
//            if ((msgBuffer) == NULL)
//                errorFlag = @"buffer allocation failure";
//            else
//            {
//                // Get system information, store in buffer
//                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
//                    errorFlag = @"sysctl msgBuffer failure";
//            }
//        }
//    }
//    
//    // Befor going any further...
//    if (errorFlag != NULL)
//    {
//        //  DLog(@"Error: %@", errorFlag);
//        return errorFlag;
//    }
//    
//    // Map msgbuffer to interface message structure
//    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
//    
//    // Map to link-level socket structure
//    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
//    
//    // Copy link layer address data in socket structure to an array
//    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
//    
//    // Read from char array into a string object, into traditional Mac address format
//    NSString *macAddressString = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X",
//                                  macAddress[0], macAddress[1], macAddress[2],
//                                  macAddress[3], macAddress[4], macAddress[5]];
//    //NSLog(@"Mac Address: %@", macAddressString);
//    
//    // Release the buffer memory
//    free(msgBuffer);
//    
//    return macAddressString;
//}
- (NSString *) macaddress
{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    //    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    //NSLog(@"outString:%@", outstring);
    
    free(buf);
    
    return [outstring uppercaseString];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self getInfo];
    [self serialNumber];
    [self getserialNumber];
    
    NSString *platform = [self getMachine];
    NSLog(@"手机型号:%@",platform);
    
    NSString *deviceName = [self deviceName];
    NSLog(@"手机类型:%@",deviceName);
    
    NSLog(@"手机Model:%@",[UIDevice currentDevice].model);
    
    [self defaultGateWay];
    
    [self getIphoneDeviceInfo];
    [self getBatteryInfo];
    
    NSString *macaddress = [self macaddress];
    NSLog(@"手机的MAC地址:%@",macaddress);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
