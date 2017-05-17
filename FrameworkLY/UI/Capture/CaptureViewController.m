//
//  CaptureViewController.m
//  FrameworkLY
//
//  Created by 李勇 on 2017/5/16.
//  Copyright © 2017年 ly. All rights reserved.
//

#import "CaptureViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface CaptureViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate>
@property (nonatomic, strong) AVCaptureSession *captureSession;//捕获会话
@property (nonatomic, strong) AVCaptureDevice *videoDevice;//摄像头设备
@property (nonatomic, strong) AVCaptureDeviceInput *videoDeviceInput;//视频设备输入对象
@property (nonatomic, strong) AVCaptureConnection *videoConnection;//视频输入与输出连接
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;//视频预览图层
@property (weak, nonatomic) IBOutlet UIButton *beginBtn;
@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UIButton *changeCameraBtn;

@property (nonatomic, strong) UIImageView *focusImgV;


@end

@implementation CaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"直播";
}

- (UIImageView *)focusImgV{
    if (!_focusImgV){
        _focusImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"focus"]];
        _focusImgV.size = CGSizeMake(64, 64);
        [self.view addSubview:_focusImgV];
    }
    return _focusImgV;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)beginCapture {
    [self.previewLayer removeFromSuperlayer];
    
    // 1.创建捕获会话,必须要强引用，否则会被释放
    AVCaptureSession *captureSession = [[AVCaptureSession alloc] init];
    self.captureSession = captureSession;
    
    // 2.获取摄像头设备，默认是后置摄像头
    AVCaptureDevice *videoDevice = [self getVideoDevice:AVCaptureDevicePositionBack];
    self.videoDevice = videoDevice;
    
    // 3.获取声音设备
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    
    // 4.创建对应视频设备输入对象
    AVCaptureDeviceInput *videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:nil];
    self.videoDeviceInput = videoDeviceInput;
    
    // 5.创建对应音频设备输入对象
    AVCaptureDeviceInput *audioDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:nil];
   
    // 6.添加到会话中
    // 注意“最好要判断是否能添加输入，会话不能添加空的
    // 6.1 添加视频
    if ([captureSession canAddInput:videoDeviceInput]){
        [captureSession addInput:videoDeviceInput];
    }
    
    // 6.2 添加音频
    if ([captureSession canAddInput:audioDeviceInput]){
        [captureSession addInput:audioDeviceInput];
    }
    
    // 7.获取视频数据输出设备
    AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    // 7.1 设置代理，捕获视频样品数据
    // 注意：队列必须是串行队列，才能获取到数据，而且不能为空
    dispatch_queue_t videoQueue = dispatch_queue_create("Video Capture Queue", DISPATCH_QUEUE_SERIAL);
    [videoOutput setSampleBufferDelegate:self queue:videoQueue];
    if ([captureSession canAddOutput:videoOutput]){
        [captureSession addOutput:videoOutput];
    }
    
    // 8.获取音频数据输出设备
    AVCaptureAudioDataOutput *audioOutput = [[AVCaptureAudioDataOutput alloc] init];
    // 8.2 设置代理，捕获视频样品数据
    // 注意：队列必须是串行队列，才能获取到数据，而且不能为空
    dispatch_queue_t audioQueue = dispatch_queue_create("Audio Capture Queue", DISPATCH_QUEUE_SERIAL);
    [audioOutput setSampleBufferDelegate:self queue:audioQueue];
    if ([captureSession canAddOutput:audioOutput]){
        [captureSession addOutput:audioOutput];
    }
    
    // 9.获取视频输入与输出连接，用于分辨音视频数据
    self.videoConnection = [videoOutput connectionWithMediaType:AVMediaTypeVideo];
    
    // 10.添加视频预览图层
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
    previewLayer.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    [self.view.layer insertSublayer:previewLayer atIndex:0];
    self.previewLayer = previewLayer;
    
    // 11.启动会话
    [captureSession startRunning];
    
    HIDETABBAR;
    HIDENAVGATION;
    self.toolView.hidden = NO;
    self.changeCameraBtn.hidden = NO;
    self.beginBtn.hidden = YES;
}

- (AVCaptureDevice *)getVideoDevice:(AVCaptureDevicePosition)position{
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == position) {
            return device;
        }
    }
    return nil;
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    if (self.videoConnection == connection){
//        NSLog(@"采集到视频数据");
    }else{
//        NSLog(@"采集到音频数据");
    }
}
- (IBAction)changeCamera {
    // 获取当前设备方向
    AVCaptureDevicePosition curPosition = self.videoDeviceInput.device.position;

    // 获取需要改变的方向
    AVCaptureDevicePosition togglePosition = curPosition == AVCaptureDevicePositionBack ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
    
    // 获取改变的摄像头设备
    AVCaptureDevice *toggleDevice = [self getVideoDevice:togglePosition];
    
    // 获取改变的摄像头输入设备
    AVCaptureDeviceInput *toggleDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:toggleDevice error:nil];
    
    // 移除之前摄像头输入设备
    [self.captureSession removeInput:self.videoDeviceInput];
    
    // 添加新的摄像头输入设备
    [self.captureSession addInput:toggleDeviceInput];
    
    // 记录当前摄像头输入设备
    self.videoDeviceInput = toggleDeviceInput;
}

//关闭
- (IBAction)closeAction {
    [self.previewLayer removeFromSuperlayer];
    
    SHOWTABBAR;
    SHOWNAVGATION;
    self.toolView.hidden = YES;
    self.changeCameraBtn.hidden = YES;
    self.beginBtn.hidden = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 获取点击位置
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    // 把当前位置转换为摄像头点上的位置
    CGPoint cameraPoint = [self.previewLayer captureDevicePointOfInterestForPoint:point];
    
    // 设置聚焦点光标位置
    [self setFocusCursorWithPoint:point];
    // 设置聚焦
    [self focusWithMode:AVCaptureFocusModeAutoFocus exposureMode:AVCaptureExposureModeAutoExpose atPoint:cameraPoint];
}

/**
 *  设置聚焦光标位置
 *
 *  @param point 光标位置
 */
-(void)setFocusCursorWithPoint:(CGPoint)point{
    self.focusImgV.center = point;
    self.focusImgV.transform = CGAffineTransformMakeScale(1.5, 1.5);
    self.focusImgV.alpha = 1.0;
    [UIView animateWithDuration:1.0 animations:^{
        self.focusImgV.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.focusImgV.alpha = 0;
    }];
}

/**
 *  设置聚焦
 */
-(void)focusWithMode:(AVCaptureFocusMode)focusMode exposureMode:(AVCaptureExposureMode)exposureMode atPoint:(CGPoint)point{

    AVCaptureDevice *captureDevice = self.videoDeviceInput.device;
    // 锁定配置
    [captureDevice lockForConfiguration:nil];
    
    // 设置聚焦
    if ([captureDevice isFocusModeSupported:focusMode]){
        [captureDevice setFocusMode:focusMode];
    }
    if ([captureDevice isFocusPointOfInterestSupported]){
        [captureDevice setFocusPointOfInterest:point];
    }
    
    // 设置曝光
    if ([captureDevice isExposureModeSupported:exposureMode]){
        [captureDevice setExposureMode:exposureMode];
    }
    if ([captureDevice isExposurePointOfInterestSupported]){
        [captureDevice setExposurePointOfInterest:point];
    }
    
    // 解锁配置
    [captureDevice unlockForConfiguration];
}

//显示工具
- (IBAction)showToolAction {
    
}

//聊天
- (IBAction)chatAction{
    
}

@end
