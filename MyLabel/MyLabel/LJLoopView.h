//
//  LJLoopView.h
//  MyLabel
//
//  Created by 东莞证券lj on 17/5/3.
//  Copyright © 2017年 dgzq. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LJLoopDelegate <NSObject>

- (void)didClickContentAtIndex:(NSInteger)index ;


@end


typedef enum {
    VerticalLoopDirectionBottom,
    VerticalLoopDirectionDown,
  } VerticalLoopDirection;

@interface LJLoopView : UIView
{
    // 创建两个label循环滚动
    UILabel *_firstContentLabel;
    UILabel *_secondContentLabel;
    
    UILabel *_firstclickLabel;
    UILabel *_secondclickLabel;
    // 记录
    int currentIndex;
}

@property(nonatomic) float verticalLoopAnimationDuration;
/**
 *  显示的内容(支持多条数据)
 */
@property(nonatomic, retain) NSMutableArray *data;
/**
 * loop方向(上下/右)
 */
@property(nonatomic) VerticalLoopDirection Direction;
@property (nonatomic, weak)id<LJLoopDelegate> loopDelegate;
/**
 *  开启
 */
-(void)start;

- (void)loopContentClick;
@end
