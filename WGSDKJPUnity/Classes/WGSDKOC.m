//
//  WGSDKOC.m
//  WGSDK
//
//  Created by 张桥 on 2020/10/12.
//

#import "WGSDKOC.h"
 

@interface WGSDKOC()
@property (nonatomic, copy) NSString *gameCode;
@property (nonatomic, copy) NSString *secret;
 
@end

@implementation WGSDKOC
 
static WGSDKOC* instance = nil;
 
+(WGSDKOC *) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}
 

- (UIViewController *)getUnityVC
{
    return [[[UIApplication sharedApplication] delegate] window].rootViewController;
}

- (void)iOSInit:(NSString *)json
{
    NSLog(@"%@",json);
    
    NSDictionary *info = [[WGSDKSwift shared] jsonToDictionary:json];
    NSString *gameCode = info[@"gameCode"];
    NSString *gameSecret = info[@"gameSecret"];
    if(gameCode && gameSecret){
        self.gameCode = gameCode;
        self.secret = gameSecret;
    } 
    NSString *twitterKey = info[@"twitterKey"];
    NSString *twitterSecret = info[@"twitterSecret"];
    NSString *adjustToken = info[@"adjustToken"];
    NSString *lineChannel = info[@"lineChannel"];
    BOOL useDebugHost = [info[@"useDebugHost"] boolValue];
    BOOL useSDKcs = [info[@"useSDKcs"] boolValue];
     
    [WGSDKSwift shared].useServiceWay = useSDKcs;
    [[WGSDKSwift shared] useDebug:useDebugHost];
    [[WGSDKSwift shared] initSDKUnityWithUseDebug:useDebugHost adjustAppToken:adjustToken lineChannelID:lineChannel twitterKey:twitterKey twitterSecret:twitterSecret];
    
}

- (void)loginWithBackgroundImageName:(NSString *)backgroundImageName loginCallBack:(GHCallBack)loginCallBack
{
    WGSDKLogin *login = [[WGSDKLogin alloc] initWithGameCode:self.gameCode gameSecret:self.secret backgroundImage:backgroundImageName];
    [[WGSDKSwift shared] useDebug:true];
    
    [[WGSDKSwift shared] login:login fromVC:[self getUnityVC] handler:^(WGSDKLoginResult * result, NSError * error) {
        if (error) {
            
             
            NSDictionary *dic = @{@"code":[NSString stringWithFormat:@"%ld",(long)error.code],
                                  @"message":error.localizedDescription};
            
            const char * errorJson = [[[WGSDKSwift shared] dictionaryToJson:dic] UTF8String];
            
            loginCallBack("",errorJson);
        }else{
            
            NSDictionary *dic = @{@"guestId":result.guestId ,
                                  @"source":result.type,
                                  @"accessToken":result.token,
                                  @"refreshToken":result.refreshToken};
            
             
            const char * resultJson = [[[WGSDKSwift shared] dictionaryToJson:dic] UTF8String];
            
            loginCallBack(resultJson,"");
            
             
        }
    }];
}

-(void)useDebug:(BOOL)useDebug
{
    [[WGSDKSwift shared] useDebug:useDebug];
}

-(void)loginOut
{
    [[WGSDKSwift shared] loginOut];
}


-(void)showWidget:(NSString *)widgetPosition
{
    NSLog(@"%@",widgetPosition);
 
    NSInteger positionInt = 1;
    if([@"LEFT_CENTER" isEqualToString:widgetPosition]){
        positionInt = WGSDKWidgetButtonPosition.left;
    }else if([@"LEFT_TOP" isEqualToString:widgetPosition]){
        positionInt = WGSDKWidgetButtonPosition.leftTop;
    }else if([@"LEFT_BOTTOM" isEqualToString:widgetPosition]){
        positionInt = WGSDKWidgetButtonPosition.leftBottom;
    }else if([@"RIGHT_CENTER" isEqualToString:widgetPosition]){
        positionInt = WGSDKWidgetButtonPosition.right;
    }else if([@"RIGHT_TOP" isEqualToString:widgetPosition]){
        positionInt = WGSDKWidgetButtonPosition.rightTop;
    }else if([@"RIGHT_BOTTOM" isEqualToString:widgetPosition]){
        positionInt = WGSDKWidgetButtonPosition.rightBottom;
    }else if([@"CENTER_TOP" isEqualToString:widgetPosition]){
        positionInt = WGSDKWidgetButtonPosition.top;
    }else if([@"CENTER_BOTTOM" isEqualToString:widgetPosition]){
        positionInt = WGSDKWidgetButtonPosition.bottom;
    }
    
    
    [[WGSDKSwift shared] showWidget:[self getUnityVC] position:positionInt];
}

-(void)removeWidget
{
    [[WGSDKSwift shared] hideWidget:[self getUnityVC]];
}

-(void)buyProduct:(NSString *)json PaymentCallBack:(GHCallBack)callBack{
    
    NSLog(@"%@",json);
    NSDictionary *info = [[WGSDKSwift shared] jsonToDictionary:json];
    NSString *productId = info[@"productId"];
    NSString *serverCode = info[@"serverCode"];
    NSString *roleId = info[@"roleId"];
    NSString *gameInfo = info[@"gameInfo"];
      
    WGSDKIAPProduct *product = [[WGSDKIAPProduct alloc] initWithProductId:productId
    serverCode:serverCode
        roleId:roleId
      roleName:@""
      gameInfo:gameInfo];
    [[WGSDKSwift shared] buyProduct:product callBack:^(WGSDKPaymentResult * result, NSError *error) {
        if (error) {
            NSDictionary *dic = @{@"code":[NSString stringWithFormat:@"%ld",(long)error.code],
                                  @"message":error.localizedDescription};
            const char * errorJson = [[[WGSDKSwift shared] dictionaryToJson:dic] UTF8String];
            callBack("",errorJson);
        }else{
            
            NSDictionary *dic = @{@"orderId":result.orderId ,
                                  @"productId":result.productId,
                                  @"purchaseTime":result.purchaseTime,
                                  @"price":result.productPrice};
            const char * resultJson = [[[WGSDKSwift shared] dictionaryToJson:dic] UTF8String];
            
            callBack(resultJson,"");
        }
    }];
}

-(void)setRole:(NSString *)roleId roleName:(NSString *)roleName serverCode:(NSString *)serverCode serverName:(NSString *)serverName SetRoleCallBack:(GHCallBack)callBack{
    
    NSLog(@"%@",serverCode);
    
    WGSDKSetRole *role = [[WGSDKSetRole alloc] initWithServerCode:serverCode serverName:serverName roleId:roleId roleName:roleName];
    [[WGSDKSwift shared] setRole:role handler:^(WGSDKSetRoleResult * result, NSError * error) {
        if (error) {
             
            NSDictionary *dic = @{@"code":[NSString stringWithFormat:@"%ld",(long)error.code],
                                  @"message":error.localizedDescription};
            const char * errorJson = [[[WGSDKSwift shared] dictionaryToJson:dic] UTF8String];
            callBack("",errorJson);
        }else{
            
            NSDictionary *dic = @{@"roleId":result.roleId ,
                                  @"roleName":result.roleName,
                                  @"serverCode":result.serverCode,
                                  @"serverName":result.serverName};
             
            const char * resultJson = [[[WGSDKSwift shared] dictionaryToJson:dic] UTF8String];
            
            callBack(resultJson,"");
            
             
        }
    }];
}

-(void)deleteRole:(NSString *)roleId serverCode:(NSString *)serverCode DeleteRoleCallBack:(GHCallBack)callBack{
    
    WGSDKDeleteRole *role = [[WGSDKDeleteRole alloc] initWithServerCode:serverCode roleId:roleId];
    [[WGSDKSwift shared] deleteRole:role handler:^(NSError * error) {
         if (error) {
             
             NSDictionary *dic = @{@"code":[NSString stringWithFormat:@"%ld",(long)error.code],
                                   @"message":error.localizedDescription};
             const char * errorJson = [[[WGSDKSwift shared] dictionaryToJson:dic] UTF8String];
             callBack("",errorJson);
         }
         else {
              
             const char * resultJson = [@"suc" UTF8String];
             
             callBack(resultJson,"");
         }
    }];
}

-(void)enterGameLog:(NSString *)roleId serverCode:(NSString *)serverCode EnterGameLogCallBack:(GHCallBack)callBack{
    
    WGSDKEnterGameLog *gameLog = [[WGSDKEnterGameLog alloc] initWithServerCode:serverCode roleId:roleId];
    [[WGSDKSwift shared] gameLog:gameLog handler:^(NSError * error) {
        if (error) {
            NSDictionary *dic = @{@"code":[NSString stringWithFormat:@"%ld",(long)error.code],
                                  @"message":error.localizedDescription};
            const char * errorJson = [[[WGSDKSwift shared] dictionaryToJson:dic] UTF8String];
            callBack("",errorJson);
        }
        else {
            const char * resultJson = [@"suc" UTF8String];
            callBack(resultJson,"");
        }

    }];
}


-(void)changeLogin:(GHCallBack)callBack{
    [[WGSDKSwift shared] setChangeAccountResultHandler:^(WGSDKLoginResult * result, NSError * error) {
        if (error) {
            
             
            NSDictionary *dic = @{@"code":[NSString stringWithFormat:@"%ld",(long)error.code],
                                  @"message":error.localizedDescription};
            
            const char * errorJson = [[[WGSDKSwift shared] dictionaryToJson:dic] UTF8String];
            
            callBack("",errorJson);
        }else{
            
            NSDictionary *dic = @{@"guestId":result.guestId ,
                                  @"source":result.type,
                                  @"accessToken":result.token,
                                  @"refreshToken":result.refreshToken};
            
             
            const char * resultJson = [[[WGSDKSwift shared] dictionaryToJson:dic] UTF8String];
            
            callBack(resultJson,"");
            
             
        }
    }];
 
}

-(void)bindCallBack:(GHCallBack)callBack{
    
    [[WGSDKSwift shared] setBindAccountHandler:^(NSString * msg) {
        const char * result = [msg UTF8String];
        callBack(result,"");
    }];
}

-(void)loginLose:(GHCallBack)callBack{
    [[WGSDKSwift shared] setNeedReLoginHandler:^{
        const char * result = "login lose";
        callBack(result,"");
    }];
 
}



@end
