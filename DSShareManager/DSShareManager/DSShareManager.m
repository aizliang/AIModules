//
//  DSShareManager.m
//  DSShareManager
//
//  Created by ai on 2017/9/26.
//  Copyright © 2017年 ai. All rights reserved.
//

#import "DSShareManager.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboSDK.h"

@interface DSShareManager ()

@end

@implementation DSShareManager

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static DSShareManager *shareManager = nil;
    dispatch_once(&onceToken, ^{
        shareManager = [[DSShareManager alloc] init];
    });
    
    return shareManager;
}


- (void)shareWithModel:(DSShareModel *)model shareType:(DSShareType)type {
    switch (type) {
        case ShareToWXSession:
            [self shareToWXWithModel:model Scene:WXSceneSession];
            break;
        case ShareToWXCicle:
            [self shareToWXWithModel:model Scene:WXSceneTimeline];
            break;
        case ShareToQQZone:
            [self shareToQQWithModel:model shareType:type];
            break;
        case ShareToQQSession:
            [self shareToQQWithModel:model shareType:type];
            break;
        case ShareToWB:
            [self shareToWBWithModel:model];
            break;
        default:
            break;
    }
    
}



//MARK: weixin
- (void)shareToWXWithModel:(DSShareModel *)model Scene:(int)scene {
    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = model.linkUrl;
    
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = model.title;
    message.description = model.content;
    message.thumbData = model.imageData;
    message.mediaObject = webObj;
    
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    
    
    [WXApi sendReq:req];
}



//MARK: QQ
- (void)shareToQQWithModel:(DSShareModel *)model shareType:(DSShareType)type {
    NSURL *url = [NSURL URLWithString:model.linkUrl];
    QQApiNewsObject *obj = [QQApiNewsObject objectWithURL:url title:model.title description:model.content previewImageData:model.imageData];
    obj.shareDestType = ShareDestTypeQQ;
    if (type == ShareToQQZone) {
        [obj setCflag:kQQAPICtrlFlagQZoneShareOnStart];
    }
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:obj];
    [QQApiInterface sendReq:req];
}



//MARK: weibo
- (void)shareToWBWithModel:(DSShareModel *)model {
    WBWebpageObject *obj = [WBWebpageObject object];
    obj.objectID = @"ddsc1";
    obj.webpageUrl = model.linkUrl;
    obj.title = model.title;
    obj.description = model.content;
    obj.thumbnailData = model.imageData;
    
    WBMessageObject *mobj = [WBMessageObject message];
    mobj.mediaObject = obj;
    
    WBSendMessageToWeiboRequest *req = [WBSendMessageToWeiboRequest request];
    req.message = mobj;
    [WeiboSDK sendRequest:req];
}
@end
