//
//  LJLoopView.m
//  MyLabel
//
//  Created by 东莞证券lj on 17/5/3.
//  Copyright © 2017年 dgzq. All rights reserved.
//

#import "LJLoopView.h"

@implementation LJLoopView

{
    BOOL _animating;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        self.data = @[@"111",@"222",@"333" ,@"444",@"111"];
    }
    return self;
}
-(void)setupView {
    
    _firstclickLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-50, 10, 50, 25)];
    _firstclickLabel.font = [UIFont systemFontOfSize:11.0];
    [_firstclickLabel.layer setMasksToBounds:YES];
    [_firstclickLabel.layer setCornerRadius:12.5];
    [_firstclickLabel.layer setBorderWidth:1.0];
    _firstclickLabel.textAlignment = NSTextAlignmentCenter;
    
    _secondclickLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-50, self.frame.size.height+10, 50, 25)];
    _secondclickLabel.font = [UIFont systemFontOfSize:11.0];
    [_secondclickLabel.layer setMasksToBounds:YES];
    [_secondclickLabel.layer setCornerRadius:12.5];
    [_secondclickLabel.layer setBorderWidth:1.0];
    _secondclickLabel.textAlignment = NSTextAlignmentCenter;
    
    _firstContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 70, self.frame.size.height)];
    [_firstContentLabel setBackgroundColor:[UIColor clearColor]];
    [_firstContentLabel setNumberOfLines:0];
    _firstContentLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesturRecongnizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loopContentClick)];
    tapGesturRecongnizer1.numberOfTapsRequired = 1;
    [_firstContentLabel addGestureRecognizer:tapGesturRecongnizer1];
    
    //    _firstContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _firstContentLabel.font=[UIFont boldSystemFontOfSize:12.f];
    
    _secondContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.height , self.frame.size.width - 70, self.frame.size.height)];
    [_secondContentLabel setBackgroundColor:[UIColor clearColor]];
    //    _secondContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [_secondContentLabel setNumberOfLines:0];
    _secondContentLabel.userInteractionEnabled = YES;
    _secondContentLabel.font=[UIFont boldSystemFontOfSize:12.f];
    
    UITapGestureRecognizer *tapGesturRecongnizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loopContentClick)];
    tapGesturRecongnizer2.numberOfTapsRequired = 1;
    [_secondContentLabel addGestureRecognizer:tapGesturRecongnizer2];
    
    [self addSubview:_firstContentLabel];
    [self addSubview:_secondContentLabel];
    [self addSubview:_firstclickLabel];
    [self addSubview:_secondclickLabel];
    
    // 默认初始方向是向上
    _Direction = VerticalLoopDirectionDown;
    _verticalLoopAnimationDuration = 0.5;
    self.clipsToBounds = YES;
}
-(void)startVerticalLoopAnimation{
    NSMutableArray *data = [self.data copy];
    if (currentIndex >= data.count) {
        [self verticalLoopAnimationDidStop:nil finished:nil context:nil];
        return;
    }
    
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:4];
    //创建 NSMutableAttributedString
    NSMutableAttributedString *attributedStr01 = [[NSMutableAttributedString alloc] initWithString: [data objectAtIndex:currentIndex]];
    [attributedStr01 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [@"第一个" length])];
    //添加属性
    //分段控制，最开始4个字符颜色设置成颜色
    
        //赋值给显示控件label01的 attributedText
    _firstContentLabel.attributedText = attributedStr01;
    [_firstContentLabel setNeedsDisplay];
    
    _firstclickLabel.text = @"点击1";
    
    float firstContentLaStartY = 0;
    float firstContentLaEndY = 0;
    float secondContentLaStartY = 0;
    float secondContentLaEndY = 0;
    
    int secondCurrentIndex  = currentIndex + 1;
    if (secondCurrentIndex > data.count - 1) {
        secondCurrentIndex = 0;
    }
    
    switch (_Direction) {
        case VerticalLoopDirectionBottom:
            
            firstContentLaStartY = 0;
            firstContentLaEndY = self.frame.size.height;
            
            secondContentLaStartY = firstContentLaStartY - self.frame.size.height;
            secondContentLaEndY = firstContentLaEndY - self.frame.size.height;
            
            break;
        case VerticalLoopDirectionDown:
            
            firstContentLaStartY = 0;
            firstContentLaEndY = -self.frame.size.height;
            
            secondContentLaStartY = firstContentLaStartY + self.frame.size.height;
            secondContentLaEndY = firstContentLaEndY + self.frame.size.height;
            
            break;
        default:
            break;
    }
    
    NSMutableAttributedString *attributedStr02 = [[NSMutableAttributedString alloc] initWithString:[data objectAtIndex:currentIndex + 1]];
    
    
    [attributedStr02 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [@"第二个" length])];
    
    //添加属性
    //分段控制，最开始4个字符颜色设置成颜色
//    for(int i = 0;i<secondAd.styleArray.count;i++){
//        NSInteger targetLength02 = secondAd.styleArray[i].target.length;
//        if(secondAd.styleArray[i].color !=nil && targetLength02 >0){
//            [attributedStr02 addAttribute: NSForegroundColorAttributeName value: [UIColor colorWithHexString:secondAd.styleArray[i].color] range: [secondAd.desc rangeOfString:secondAd.styleArray[i].target]];
//        }
//        if(secondAd.styleArray[i].bold && targetLength02 >0){
//            [attributedStr02 addAttribute:NSStrokeWidthAttributeName value:@(-3) range:[secondAd.desc rangeOfString:secondAd.styleArray[i].target]];
//        }
//        
//    }
    
    _secondContentLabel.attributedText = attributedStr02;
    [_secondContentLabel setNeedsDisplay];
    _secondclickLabel.text = @"点击2";
    
    _firstContentLabel.frame = CGRectMake(10, firstContentLaStartY, self.frame.size.width - 70, self.frame.size.height);
    _secondContentLabel.frame = CGRectMake(10, secondContentLaStartY, self.frame.size.width - 70, self.frame.size.height);
    
    _firstclickLabel.frame = CGRectMake(self.frame.size.width-50, firstContentLaStartY+10, 50, 25);
    _secondclickLabel.frame = CGRectMake(self.frame.size.width-50, secondContentLaStartY+10, 50, 25);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(00 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self didAnimation:firstContentLaEndY secondContent:secondContentLaEndY];
    });
    
}
-(void)verticalLoopAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    currentIndex++;
    if(currentIndex + 1  >= [self.data count]) {
        currentIndex = 0;
    }
    __weak LJLoopView *weakSelf = self;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf startVerticalLoopAnimation];
    });
    
    
}
- (void)loopContentClick
{
    if ([self.loopDelegate respondsToSelector:@selector(didClickContentAtIndex:)]) {
        [self.loopDelegate didClickContentAtIndex:currentIndex];
    }
}

#pragma mark - verticalLoop Animation Handling
-(void)start {
    
    // 开启动画默认第一条信息
    currentIndex = 0;
    // 开始动画
    if (!_animating) {
        _animating = YES;
        [self performSelectorOnMainThread:@selector(startVerticalLoopAnimation) withObject:nil waitUntilDone:NO];
        //        [self startVerticalLoopAnimation];
    }
}

-(void)didAnimation:(float)firstContentLaEndY secondContent:(float)secondContentLaEndY
{
    if([self.data count]>1){
        [UIView beginAnimations:@"" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationDuration:_verticalLoopAnimationDuration];
        [UIView setAnimationDelay:1];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(verticalLoopAnimationDidStop:finished:context:)];
        CGRect firstContentLabelFrame = _firstContentLabel.frame;
        firstContentLabelFrame.origin.y = firstContentLaEndY;
        
        [_firstContentLabel setFrame:firstContentLabelFrame];
        [_secondContentLabel setFrame:CGRectMake(10,secondContentLaEndY, self.frame.size.width - 70, self.frame.size.height)];
        
        CGRect firstClickLabelFrame = _firstclickLabel.frame;
        firstClickLabelFrame.origin.y = firstContentLaEndY+10;
        [_firstclickLabel setFrame:firstClickLabelFrame];
        [_secondclickLabel setFrame:CGRectMake(self.frame.size.width-50, secondContentLaEndY+10, 50, 25)];
        
        [UIView commitAnimations];
    }else{
        _animating = NO;
    }
    
}
@end
