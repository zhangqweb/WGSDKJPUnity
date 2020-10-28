//
//  WGSDKOC.h
//  WGSDK
//
//  Created by 张桥 on 2020/10/12.
//

#import <Foundation/Foundation.h>
#import <WGSDK/WGSDK-Swift.h>
 
 


extern UIViewController* UnityGetGLViewController();
 


@interface WGSDKOC : NSObject
 

typedef void (*GHCallBack)(const char *reslut,const char *error);


+ (WGSDKOC *) sharedInstance;

- (void)iOSInit:(NSString *)json;
- (void)loginWithBackgroundImageName:(NSString *)backgroundImageName loginCallBack:(GHCallBack)loginCallBack;
- (void)useDebug:(BOOL)useDebug;

-(void)loginOut;
-(void)showWidget:(NSString *)widgetPosition;
-(void)removeWidget;
-(void)buyProduct:(NSString *)json PaymentCallBack:(GHCallBack)callBack;
-(void)setRole:(NSString *)roleId roleName:(NSString *)roleName serverCode:(NSString *)serverCode serverName:(NSString *)serverName SetRoleCallBack:(GHCallBack)callBack;
-(void)deleteRole:(NSString *)roleId serverCode:(NSString *)serverCode DeleteRoleCallBack:(GHCallBack)callBack;
-(void)enterGameLog:(NSString *)roleId serverCode:(NSString *)serverCode EnterGameLogCallBack:(GHCallBack)callBack;
-(void)changeLogin:(GHCallBack)callBack;
-(void)bindCallBack:(GHCallBack)callBack;
-(void)loginLose:(GHCallBack)callBack;
@end



 
