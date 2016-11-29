//
//  Header.h
//  ResourcesObject
//
//  Created by zhengxingxia on 16/6/20.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#ifndef Header_h
#define Header_h



#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define COEFFICIENT     (SCREEN_WIDTH/320.f)

#define CURRENT_SIZE(_SIZE) _SIZE/375.0*SCREEN_WIDTH //当前的宽高比

#define WeakSelf __weak typeof(self) weakSelf = self;

// 主题颜色
#define MainColor             [JMTool colorWithHexString:@"#c09961"]  // 类咖啡色
// 字体主色调
#define MainFontColor         [JMTool colorWithHexString:@"#3e3a39"]  // 类似黑色
// 间距背景主色调
#define backGroundColor       [UIColor colorWithWhite:0.961 alpha:1]  // 淡灰色

#define shadow_Color           [UIColor colorWithWhite:0.3 alpha:0.3]

#define lineColor             [UIColor colorWithRed:0.914 green:0.918 blue:0.922 alpha:1.000]

#define RGB(r, g, b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define isIOS7  (([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0)?YES:NO)

#define isIOS8  (([[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0)?YES:NO)

#define isIOS9  (([[[UIDevice currentDevice]systemVersion] floatValue] >= 9.0)?YES:NO)

#define isIOS10  (([[[UIDevice currentDevice]systemVersion] floatValue] >= 10.0)?YES:NO)


#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define MAIN_FONT(a)  isIOS9?[UIFont fontWithName:ping_fang_regular size:(a)]:[UIFont fontWithName:@"HelveticaNeue" size:(a)];
#define MAIN_BOLD_FONT(a)  isIOS9?[UIFont fontWithName:ping_fang_bold size:(a)]:[UIFont fontWithName:@"HelveticaNeue-Bold" size:(a)];

#define navHeight (40*COEFFICIENT+20)

// 用户信息KEY
#define USER_INFO_KEY @"userInfoKey"
#define lat_KEY @"lat"
#define lng_KEY @"lng"

#define acessToken @"two/CQLkNA0kG1SygDvBh4sXRYh6ArXrTxu5sZVvDcp7td5V3l4DVuLI28v2oIaK/7MX8HpneWkYOLcGjiPF2A=="

// 各平台key值

static NSString *const UMAppKey = @"582970c8bbea837c70002100";

static NSString *const WeiXinAppKey = @"wxa50d6600268d8bb0";
static NSString *const WeiXinAppSecret = @"010341aa80138c6423057cdb2b1664cf";
static NSString *const QQAppId = @"1105824032";
static NSString *const QQAppKey = @"Sqh2sIXztPU7H1I8";


static const float shoppingcarHeight = 40.f;        // 购物车高度

// 字体
static NSString *const ping_fang_bold = @"PingFangSC-Semibold";

static NSString *const ping_fang_regular = @"PingFangSC-Regular";
/**系统粗体*/
static NSString *const SYSTEM_BOLD = @"Helvetica-Bold";

// NSUserdefault Keys
static NSString *const IS_NETCONNECT_LOST = @"isNetConnectLost";

static NSString *const REFRESH_UI = @"refreshUI";


// URL

// IP 正式地址

#define IP_ADRESS_URL(...)          [NSString stringWithFormat:@"http://www.toutime.com.cn/coffeeInterface/%@",##__VA_ARGS__]

//// IP 测试地址
////
//#define IP_ADRESS_URL(...)          [NSString stringWithFormat:@"http://192.168.1.110:8089/coffeeInterface/%@",##__VA_ARGS__]


////地图搜索
//static NSString *const BAIDUMAP_SEARCH_URL = @"http://api.map.baidu.com/place/v2/search";
//
////关键字推荐
//static NSString *const BAIDUMAP_SUGGESTION_URL = @"http://api.map.baidu.com/place/v2/suggestion/";

#define CUSTOM_QUESTION(...)        IP_ADRESS_URL([NSString stringWithFormat:@"%@%d%@",@"phone/problem",##__VA_ARGS__,@".html"])

//下载地址
static NSString *const APP_DOWNLOAD_URL = @"http://www.toutime.com.cn/app/appdown.html";

//关于偷时
static NSString *const ABOUT_TOUTIME_URL = @"phone/about.html";

//1.1 用户登录
static NSString *const LOGIN_APP_URL = @"user/loginApp.htm";

//1.2 修改密码
static NSString *const UPDATEPWD_URL = @"user/updateUserPasswordNew.htm";

//1.3 忘记密码
static NSString *const FORGETPWD_URL = @"user/forgetUserPassword.htm";

//1.4 注册
static NSString *const QUICK_LOGIN_URL = @"user/registerUser.htm";

//1.5 获得验证码
static NSString *const VERIFICATION_URL = @"user/obtainVerificationCode.htm";

//1.9判断第三方是否过  第三方登录（OK）兴旺
static NSString *const LOGIN_THREE_URL = @"user/loginThree.htm";

//1.12 我的消息未读数量（OK）兴旺
static NSString *const UNREAD_MESSAGE_URL = @"user/findUserMsgUnReadCount.htm";

//1.13 我的消息列表
static NSString *const FINDUSERMSGLIST_URL = @"user/findUserMsgList.htm";

//1.17 查询用户信息（OK）兴旺
static NSString *const CHECK_USER_INFO_URL = @"user/findUserInfo.htm";

//1.18 修改用户信息
static NSString *const UPDATEUSERINFO_URL = @"user/updateUserBaseInfo.htm";

//1.20 大咖秀列表
static NSString *const FINDMANAGER_LIST_URL = @"user/findManagerList.htm";

//1.21 用户等级信息
static NSString *const FINDUSERINFO_URL = @"user/findUserGradeInfo.htm";

//1.22 判断支付密码 赵
static NSString *const CHECK_PASSWORD_URL = @"user/checkPayPassword.htm";

//1.23 咖啡申领
static NSString *const APPLYCOFFEEPRODUCT_URL = @"user/applyCoffeeProduct.htm";

//1.24 用户当前积分和秒杀剩余数量
static NSString *const FINDUSERINTEGRAL_URL = @"user/findUserIntegral.htm";

//1.25 1.25秒杀优惠券
static NSString *const USERMIAOSHA_URL = @"user/userMiaosha.htm";

//1.26分享加积分（OK）赵
static NSString *const SHARE_SUCCESS_URL = @"user/addUserIntegral.htm";

//2.1 活动列表
static NSString *const ACTIVITY_LIST_URL = @"activity/findActivityList.htm";

//2.2 活动介绍
static NSString *const ACTIVITY_INFO_URL = @"activity/findActivityInfo.htm";

//2.3活动报名(支付未处理)
static NSString *const JIONACTIVITY_URL =  @"activity/joinActivity.htm";

//2.4 评论列表
static NSString *const COMMENT_LIST_URL = @"activity/findCommentList.htm";

//2.5 添加评论
static NSString *const ADDCOMMENT_MSG_URL = @"activity/addNewsCommentMsg.htm";

//2.5.1 添加订单评论(OK) 赵
static NSString *const ADD_ORDER_COMMENT_URL = @"activity/addCommentMsg.htm";

//2.6 我的活动列表
static NSString *const MYACTIVITY_LIST_URL =  @"activity/myActivityList.htm";

//3.0 文章和置顶列表
static NSString *const NEWSTOP_LIST_URL = @"news/findNewsTopList.htm";

//3.1 文章教程列表(包括了分类3.3)
//static NSString *const FINDNEWS_LIST_URL =  @"news/findNewsList.htm";
//
//3.2 文章教程置顶列表
//static NSString *const TOPNEWS_LIST_URL = @"news/findTopNewsList.htm";

//3.4 文章教程详情-网页内容
static NSString * const NEWSDETAIL_WEB_URL = @"http://182.254.135.211:8099/coffeeInterface/phone/newsDetailApp.jsp";

//3.5订单日志详情（OK）
static NSString * const ORDER_STATUS_URL = @"order/findOrderLogsList.htm";

//3.5 商品推荐列表
static NSString * const PRODUCTRECOMMEND_LIST_URL =  @"news/findProductRecommendList.htm";

//3.6 文章教程详情
static NSString * const NEWSDETAIL_INFO_URL = @"news/findNewsDetailInfo.htm";

//4.1 首页广告banner列表
static NSString * const BANNER_LIST_URL = @"activity/homeBannerList.htm";

//4.2 首页公告列表
static NSString * const NOTICE_LIST_URL = @"activity/homeNoticeList.htm";

//4.3 热门城市列表
static NSString * const CITYHOT_LIST_URL = @"activity/cityHotList.htm";

//5.1 收货地址列表
static NSString * const ADDRESS_LIST_URL = @"user/findUserReceiveInfoList.htm";

//5.2 删除收货地址（OK）兴旺
static NSString * const DELETE_ADDRESS_URL = @"user/delUserReceiveInfo.htm";

//5.3 新增修改收货地址（OK）兴旺
static NSString * const ADD_ADDRESS_URL = @"user/addUserReceiveInfo.htm";

//5.3.1收货地址设置默认（OK）狄金友
static NSString * const SET_DEFAULT_ADDRESS_URL = @"user/upUserReceiveInfo.htm";

//5.4 关注（OK）赵
static NSString * const FOLLOW_URL = @"user/addCollectionInfo.htm";

//5.5 取消关注（OK）赵
static NSString * const UNFOLLOW_URL = @"user/delCollectionInfo.htm";

//5.6.1 关注的好友列表10.2接口（OK） 金友
static NSString * const FOLLOW_LIST_URL = @"user/myCollectionList.htm";

//5.7 我的兑换券列表
static NSString * const CONVERT_LIST_URL = @"user/myCouponList.htm";

//5.7.1 我的折扣卡列表
static NSString * const ZHEKOUCARD_LIST_URL = @"user/myZhekouCardList.htm";

//5.8 积分商品列表
static NSString * const FINDINTEGRALPRODUCT_LIST_URL = @"user/findIntegralProductList.htm";

//5.9 签到
static NSString * const SIGN_IN_URL = @"user/userSign.htm";

//5.10 偷时
static NSString * const USER_TOUTIME_URL = @"user/userTouTime.htm";

//5.11 用户当月签到列表
static NSString * const USER_SIGNDAY_LIST_URL = @"user/userSighDayList.htm";

//5.13 咖啡豆充值
static NSString * const CREATEORDER_BEANS_URL = @"order/createOrderWallet.htm";

//5.16 积分记录
static NSString *const  FINDUSERINTEGRAL_LIST_URL = @"user/findUserIntegralLogList.htm";

//6.1 商家列表
static NSString * const FINDSHOP_LIST_URL = @"shop/findShopList.htm";

//6.2 商家详情（OK）金友
static NSString * const SHOP_INFO_URL = @"shop/findShopMsg.htm";

//7.1 商品列表
static NSString * const GOODS_LIST_URL = @"product/findProductList.htm";

//8.1 加入购物车 （OK）兴旺
static NSString * const ADD_SHOPPINGCAR_URL = @"order/addShoppingCartInfo.htm";

//8.2购物车列表（OK）兴旺
static NSString * const SHOPPINGCAR_LIST_URL = @"order/findShoppingCartList.htm";

//8.3 删除购物车商品（OK）兴旺
static NSString * const DELETE_SHOPPINGCAR_GOODS_URL = @"order/deleteShoppingCart.htm";

//8.3.1 删除购物车全部失效商品（OK）兴旺
static NSString * const CLEAR_SHOPPINGCAR_RELEASEGOODS_URL = @"order/deleteShoppingCartAllNoValid.htm";

//8.4 生成订单（OK）兴旺
static NSString * const SUBMIT_ORDER_URL = @"order/addOrder.htm";

//8.5 订单列表
static NSString * const FINDORDERLIST_URL = @"order/findOrderList.htm";

//8.8 修改订单状态
static NSString * const UPDATEORDER_STATUS_URL = @"order/updateOrderStatus.htm";

//8.9取消订单原因（OK）赵
static NSString * const CANCEL_REASON_URL = @"order/saveCancelOrderReason.htm";

//8.11 删除订单
static NSString * const DELEORDERMSG_URL = @"order/deleteOrderMsg.htm";

//8.12支付界面接口（OK） 赵瑞可
static NSString * const Ensure_Order_Url = @"order/findShopCartPayProductList.htm";

//8.13购买咖啡下单--支付宝支付参数（OK）赵瑞可
static NSString * const GET_ORDERSTRING_ALIPAY_URL = @"order/findAlipayParam.htm";

//8.14购买咖啡下单--微信支付参数获取（OK）赵瑞可
static NSString * const GET_ORDERSTRING_WEIXIN_URL = @"order/findWXPayAppParam.htm";

//9.1 空间列表
static NSString * const FINDSPACE_LIST_URL =  @"user/findSpaceList.htm";

//9.3 用户点赞（OK）赵
static NSString * const USER_ZAN_URL = @"user/addZanUserInfo.htm";

//9.4 空间取消点赞
static NSString * const DELZANUSER_INFO_URL = @"user/delZanUserInfo.htm";

//10.1 推荐文章、商店、商品、活动
static NSString * const COMMAND_HOME_URL = @"activity/tuiMsg.htm";

//10.3 偷时首页（OK）兴旺
static NSString * const TOUTIME_HOME_DATA_URL = @"user/findWhenStealingInfo.htm";

//10.4 图文教程、器具原料、海量咨询，大咖文章列表列表（OK）赵
static NSString * const ARTICLE_LIST_URL = @"news/findNewsList.htm";

//10.41 视频列表
static NSString * const FINDVIDEO_LIST_URL = @"news/findNewsVideoList.htm";

//10.5 文章内容webview地址（OK）赵
static NSString * const GET_ARTICLE_URLSTRING_URL = @"phone/newsDetail.jsp";

//10.5.1 文章内容+作者信息 地址（OK）赵
static NSString * const ARTICLE_HTML_URL = @"news/findNewsDetail.htm";

//10.6 大咖文章图片列表（OK）赵
static NSString * const ARTICLE_IMAGES_URL = @"news/findNewsPhotoList.htm";

//10.9 首页搜索大咖，某级别的大咖类别（OK）赵
static NSString * const SHOW_PEOPLE_LIST_URL = @"news/findBigPersonList.htm";

//10.10三级别的大咖列表（OK）赵
static NSString * const SHOW_THREE_LIST_URL = @"news/findBigPersonThreeList.htm";

//10.11 增加转发数
static NSString * const ADD_SHARENUM_URL = @"user/addNewsZhuafaCount.htm";

//11.1 商品名称列表
static NSString * const FINDPRODUCTNAME_LIST_URL = @"product/findProductNameList.htm";

//11.3 争做榜首列表
static NSString * const COUTIME_TIME_CHARTS_URL = @"user/getUserTouIntegralList.htm";

//11.4 我的商品对换列表
static NSString * const MYEXCHANGE_RECORDS_URL = @"product/myExchangeRecords.htm";

//11.5 商家列表含有商家产品分类所有元素
static NSString * const FIND_SHOPLIST_BYPRODUCT_URL = @"shop/findShopByProduct.htm";

//11.6 积分商品兑换
static NSString * const INTEGRALPRODUCT_EXCHANGE_URL = @"product/integralProductExchange.htm";

//11.7 可能认识的人
static NSString * const GET_POSSIBLE_FRIEND_URL = @"user/getPossibleFriends.htm";

//11.8 添加好友消息
static NSString * const ADD_FRIEND_URL = @"user/addUserMsg.htm";

//11.10 手机通讯录好友
static NSString * const FINDUSERFRIEND_URL = @"user/findUserFriend.htm";

//11.11 新增修改商家
static NSString * const USERAPPLYSHOP_URL = @"user/userApplyShop.htm";

//11.12 设置支付密码
static NSString * const FORGETPAYPWD_URL = @"user/ForgetUserPayPassword.htm";

//11.12 绑定手机号
static NSString * const BANGUSERPHONE_URL = @"user/bangUserPhone.htm";

//11.14 偷时分享二维码地址（OK） 赵
static NSString * const CODE_IMAGE_URL = @"user/inviteFriendQrcode.htm";

//11.15 偷时分享点击地址接口（OK） 赵
static NSString * const SHARE_INVITE_URL = @"user/inviteFriendShareUrl.htm";

//12.1 系统开关（充值开关，邀请好友开关）接口（OK） 赵
static NSString * const SYSTEM_SWITCH_URL = @"user/findInviteSwitch.htm";

//12.4添加、修改发票接口（OK） 赵
static NSString * const ADD_INVOICES_URL = @"order/addUserInvoices.htm";

//12.5用户发票抬头列表接口（OK） 赵
static NSString * const USER_INVOICES_URL = @"order/findUserInvoices.htm";


//13.1 课程列表
static NSString * const FINDCOURSELIST_URL = @"news/findCourseList.htm";

//13.2课程详情4个课程
static NSString * const FINDCOURSEALLDETAIL_URL = @"news/findCourseAllDetail.htm";

//13.3课程下单
static NSString * const  ADD_ORDERCOURSE_URL = @"order/addOrderCourse.htm";

//13.4课程订单列表（OK） 赵
static NSString * const ORDER_COURSE_LIST_URL = @"order/findOrderCourseList.htm";

//13.5一个课程的时间地点
static NSString * const  FINDCOURSETIME_LIST_URL = @"news/findCourseTimeList.htm";

//13.6 全额支付成功获取
static NSString * const FINDORDERCOURSE_CODE_URL = @"order/findOrderCourseCode.htm";

// 二维码地址
static NSString * const ERWEIMA_URL = @"http://115.159.51.111:8080/coffeeInterface/user/inviteFriendQrcode.htm";
// 二维码KEY
#define ERWEIMA_KEY @"myerweimakey"

// 课程活动规则
static NSString * const ACTIVERULE_URL = @"phone/activeRule.html";

#endif /* Header_h */
