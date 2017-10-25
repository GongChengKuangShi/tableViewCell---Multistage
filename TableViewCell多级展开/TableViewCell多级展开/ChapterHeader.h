//
//  ChapterHeader.h
//  TableViewCell多级展开
//
//  Created by xrh on 2017/10/23.
//  Copyright © 2017年 xrh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChapterHeaderDelegate  <NSObject>

- (void)didtouchButtonEvent:(UIButton *)button;

@end

@interface ChapterHeader : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) id<ChapterHeaderDelegate> delegate;

- (IBAction)touchButtonEvent:(UIButton *)sender;

- (void)loadDataWithArray:(NSArray *)array Section:(NSInteger)section SectionStatus:(BOOL)sectionStatus;

@end
