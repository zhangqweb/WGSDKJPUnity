//
//  WeGamesUnity.m
//  WGSDKUnity
//
//  Created by 张桥 on 2020/10/10.
//

#import "WGSDKUnity.h"
#import "WGSDKOC.h"

@implementation WGSDKUnity
@end



extern "C"{
    void GHIOSInit(const char *json){
        
        [[WGSDKOC sharedInstance] iOSInit:[NSString stringWithUTF8String:json]];
    }
    
    void GHIOSLogin(const char *backgroundImageName,GHCallBack callBack)
    {
        [[WGSDKOC sharedInstance] loginWithBackgroundImageName:[NSString stringWithUTF8String:backgroundImageName] loginCallBack:callBack];
    }

    void GHIOSUseDebug(BOOL useDebug)
    {
        [[WGSDKOC sharedInstance] useDebug:useDebug];
    }

    void GHIOSLogOut()
    {
        [[WGSDKOC sharedInstance] loginOut];
    }
    
    void GHIOSAddWidget(const char *widgetPosition)
    {
        [[WGSDKOC sharedInstance] showWidget:[NSString stringWithUTF8String:widgetPosition]];
    }

    void GHIOSRemoveWidget()
    {
        [[WGSDKOC sharedInstance] removeWidget];
    }

    void GHIOSRequestIAPProduct(const char *json,
                                GHCallBack callBack)
    {
        
        [[WGSDKOC sharedInstance] buyProduct:[NSString stringWithUTF8String:json]
                             PaymentCallBack:callBack];
    }

    void GHIOSSetRole(const char *serverCode,
                            const char *roleId,
                            const char *roleName,
                            const char *serverName,
                      GHCallBack callBack)
    {
        [[WGSDKOC sharedInstance] setRole:[NSString stringWithUTF8String:roleId]
                                 roleName:[NSString stringWithUTF8String:roleName]
                               serverCode:[NSString stringWithUTF8String:serverCode]
                               serverName:[NSString stringWithUTF8String:serverName]
                          SetRoleCallBack:callBack];
    }


    void GHIOSDeleteRole(const char *serverCode,
                            const char *roleId,
                         GHCallBack callBack)
    {
        [[WGSDKOC sharedInstance] deleteRole:[NSString stringWithUTF8String:roleId]
                                  serverCode:[NSString stringWithUTF8String:serverCode]
                          DeleteRoleCallBack:callBack];
    }

    void GHIOSEnterGameLog(const char *serverCode,
                            const char *roleId,
                           GHCallBack callBack)
    {
        [[WGSDKOC sharedInstance] enterGameLog:[NSString stringWithUTF8String:roleId]
                                    serverCode:[NSString stringWithUTF8String:serverCode]
                          EnterGameLogCallBack:callBack];
    }

    void GHIOSBindCallBack(GHCallBack callBack)
    {
        [[WGSDKOC sharedInstance] bindCallBack:callBack];
    }

    void GHIOSChangeLogin(GHCallBack callBack)
    {
        [[WGSDKOC sharedInstance] changeLogin:callBack];
    }

    void GHIOSLoginLose(GHCallBack callBack)
    {
        [[WGSDKOC sharedInstance] loginLose:callBack];
    }
}
