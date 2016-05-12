//
//  CallmeViewController.m
//  lq0578
//
//  Created by 汤维炜 on 16/2/26.
//  Copyright © 2016年 汤维炜. All rights reserved.
//

#import "CallmeViewController.h"
#import <MessageUI/MessageUI.h>
#import "SVProgressHUD.h"

//
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
//
#import "MobClick.h"

#define viewwidth self.view.frame.size.width
#define viewheight self.view.frame.size.height

#define kUMeng_KEY   @"54c5f13ffd98c5e8f0000506" // @"56df797be0f55a4d2100189a"

#define KWeiXin_AppID           @"wx003c71dcdfeb5906" //@"wx003c71dcdfeb5906"
#define KWeiXin_AppSecret       @"b65f29e6f3d8a23497c64935b5daa82e"



@interface CallmeViewController ()<UIScrollViewDelegate,MFMailComposeViewControllerDelegate,UMSocialUIDelegate>

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) NSString* email;

@end

@implementation CallmeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationUI];

    [self addScrollview];
    
    [self addTextviewField];
    
    [self addOtherDescripteLabel];
}

- (void)initNavigationUI {
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    self.navigationItem.titleView = titleView;
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 130, 44)];
    title.text = @"发布信息须知";
    title.textColor = [UIColor lightGrayColor];
    [titleView addSubview:title];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    leftItem.tintColor = [UIColor orangeColor];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor orangeColor];
}

- (void)dismiss {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"AboutFreeSendingMessage"];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
    [super viewWillDisappear:animated];
    
}

#pragma mark -UI

- (void)addScrollview {
    
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, viewwidth, viewheight)];
    [self.view addSubview:_scrollview];

    [self.view addSubview:_scrollview];
    _scrollview.alwaysBounceVertical = YES;
    _scrollview.delegate = self;
    _scrollview.contentSize = CGSizeMake(viewwidth, 600);
    _scrollview.showsVerticalScrollIndicator = NO;
}

- (void)addOtherDescripteLabel {

    UILabel *title = [[UILabel alloc] init];
    title.frame = CGRectMake(0, 8, viewwidth, 44);
    title.text = @"免费发布信息须知";
    title.textColor = [UIColor orangeColor];
    title.textAlignment = NSTextAlignmentCenter;
    [_scrollview addSubview:title];
    
    // 分享按钮
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(viewwidth - 80, 30, 60, 60);
    shareButton.backgroundColor = [UIColor greenColor];
    shareButton.layer.cornerRadius = 30;
    [shareButton addTarget:self action:@selector(shareTheMessage) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [_scrollview addSubview:shareButton];
    
    UILabel *botommLab = [[UILabel alloc]init];
    botommLab.frame = CGRectMake(0, viewheight - 206, viewwidth-22, 44);
    botommLab.text = @"邮箱：278076337@qq.com";
    botommLab.font = [UIFont systemFontOfSize:12];
    botommLab.textColor = [UIColor orangeColor];
    botommLab.textAlignment = NSTextAlignmentRight;
    [_scrollview addSubview:botommLab];
    
    UIButton *emailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    emailBtn.frame = CGRectMake(0, viewheight -160, viewwidth-22, 46);
    [emailBtn setTitle:@"点击发送邮件" forState:UIControlStateNormal];
    emailBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [emailBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [emailBtn addTarget:self action:@selector(sendEmailToAppAuthor) forControlEvents:UIControlEventTouchUpInside];
    [_scrollview addSubview:emailBtn];
    
}

- (void)addTextviewField {
    NSString *content = @"亲！ 将您想发布的信息,按照对应的分类及格式发到邮箱：278076337@qq.com。 分类及格式如下：一、就业类。 发布就业信息须知：1.公司名字；2.联系方式；3.招聘人数；4.公司地址；5.工资（不公开，填面议哦~）；6.学历要求，7.工作经验要求等等；  二、黄页类。 发布电话联系方式须知：1.商家（公司）名称；2.电话号码；3.地址； 三、如果您有任何其他想合作的也可以发信息到此邮箱； 四、下一个版本将以最快速度更新，为您的生活增添“正能量”。  附：所有要求发布的内容必须符合中华人民共和国法律规定。";
    
    NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc]initWithString:content];
    NSDictionary *gray_dic = @{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:13]};
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:8];
    [attstring addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [attstring length])];
    [attstring addAttributes:gray_dic range:NSMakeRange(0, [attstring length])];
    
    UILabel *textlabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 44, viewwidth-16, viewheight-68-44-100)];
    textlabel.attributedText = attstring;
    textlabel.numberOfLines = 0;
    textlabel.backgroundColor = [UIColor whiteColor];
    
    [_scrollview addSubview:textlabel];
}

#pragma mark - Action
- (void)sendEmailToAppAuthor {
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    
    [mailPicker setSubject:@"eMail主题"];
    
    // 添加发送者
    NSArray *toRecipients = [NSArray arrayWithObject:@"278076337@qq.com"];
    
    [mailPicker setToRecipients:toRecipients];
    
    
    NSString *emailBody = @"eMail 正文";
    [mailPicker setMessageBody:emailBody isHTML:YES];
   
    [self presentViewController:mailPicker animated:YES completion:nil];
}

-(void)launchMailAppOnDevice {
    NSString *recipients = @"mailto:278076337@qq.com&subject=my email!";
    //@"mailto:first@example.com?cc=second@example.com,third@example.com&subject=my email!";
    NSString *body = @"&body=email body!";
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

-(void)sendEMail {
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (mailClass != nil) {
        if ([mailClass canSendMail]) {
            [self sendEmailToAppAuthor];
        } else {
            [self launchMailAppOnDevice];
        }
    } else {
        [self launchMailAppOnDevice];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    NSString *msg;
    
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = @"邮件发送取消";
            break;
        case MFMailComposeResultSaved:
            msg = @"邮件保存成功";
            [self alertWithTitle:nil msg:msg];
            break;
        case MFMailComposeResultSent:
            msg = @"邮件发送成功";
            [self alertWithTitle:nil msg:msg];
            break;
        case MFMailComposeResultFailed:
            msg = @"邮件发送失败";
            [self alertWithTitle:nil msg:msg];
            break;
        default:
            break;
    }
    
    NSLog(@"发送结果：%@", msg);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) alertWithTitle:(NSString *)_title_ msg:(NSString *)msg {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_title_
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
    
}

- (void)shareTheMessage {
    
    // 纯图片
    
    NSString *imageNSUrl = @"http://www.cnblogs.com/tony0571/p/4925518.html";
    [UMSocialWechatHandler setWXAppId:KWeiXin_AppID appSecret:KWeiXin_AppSecret url:imageNSUrl];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = imageNSUrl;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = imageNSUrl;
    
    UIImage *images = [UIImage imageNamed:@"LOGO-114.png"];
    
    [UMSocialSnsService presentSnsIconSheetView:self.view.window.rootViewController
                                         appKey:kUMeng_KEY
                                      shareText:@"欢迎发建议到278076337@qq.com"
                                     shareImage:images
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,nil]
                                       delegate:self];
    
}

#pragma mark UMSocialUIDelegate

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
    [SVProgressHUD showWithStatus:@"亲，谢谢分享哦~"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
