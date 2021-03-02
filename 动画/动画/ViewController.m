//
//  ViewController.m
//  动画
//
//  Created by iiik- on 2021/3/2.
//

#import "ViewController.h"
#define angleZRad(angle) ((angle) / 180.0 * M_PI)

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (assign, nonatomic) int i;
@end

@implementation ViewController

- (int)i {
    if (!_i) {
        _i = 1;
    }
    return _i;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"%@",NSStringFromCGRect(self.imageV.frame));
    NSLog(@"%@",self.imageV.image);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self animationFromToValues];
    //NSLog(@"%@",NSStringFromCGRect(self.imageV.frame));
    NSLog(@"%@",self.imageV.image);
}

//转场动画
- (void)CATransitionAnim {
    //转场代码跟转场动画必须连在一起
    CATransition *anim = [CATransition animation];
    anim.type = @"push";
    self.i++;
    NSString *image = [NSString stringWithFormat:@"%d",self.i];
    self.imageV.image = [UIImage imageNamed:image];
    [self.imageV.layer addAnimation:anim forKey:nil];
}
//动画组
- (void)animationGroup {
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"position.y";
    anim.toValue = @400;
    
    CABasicAnimation *anim2 = [CABasicAnimation animation];
    anim2.keyPath = @"transform.scale";
    anim2.toValue = @0.5;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[anim,anim2];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    
    [self.imageV.layer addAnimation:group forKey:nil];
}
//动画添加路径
- (void)animationPath {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    //贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    //起点
    [path moveToPoint:CGPointMake(50, 50)];
    //连线
    [path addLineToPoint:CGPointMake(300, 50)];
    anim.duration = 0.5;
    //动画保持最后一个状态
    anim.fillMode = kCAFillModeForwards;
    anim.path = path.CGPath;
    //动画执行完不会被自动删除
    anim.removedOnCompletion = NO;
    [self.imageV.layer addAnimation:anim forKey:nil];
}
//动画设置多个变化的值
- (void)animationValues {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.values = @[@angleZRad(-5),@angleZRad(5)];
    //自动反转
    anim.autoreverses = YES;
    anim.repeatCount = MAXFLOAT;
    [self.imageV.layer addAnimation:anim forKey:nil];
}
//动画设置起点终点
- (void)animationFromToValues {
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale";
    anim.toValue = @0;
    anim.duration = 1;
    //设置自动反转
    anim.autoreverses = YES;
    //设置动画无线执行
    anim.repeatCount = MAXFLOAT;
    [self.imageV.layer addAnimation:anim forKey:nil];
}
@end
