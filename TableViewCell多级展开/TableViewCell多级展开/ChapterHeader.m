//
//  ChapterHeader.m
//  TableViewCell多级展开
//
//  Created by xrh on 2017/10/23.
//  Copyright © 2017年 xrh. All rights reserved.
//

#import "ChapterHeader.h"

@implementation ChapterHeader

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)touchButtonEvent:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(didtouchButtonEvent:)]) {
        [_delegate didtouchButtonEvent:sender];
    }
}

- (void)loadDataWithArray:(NSArray *)array Section:(NSInteger)section SectionStatus:(BOOL)sectionStatus {
    
    NSDictionary *sectionDic = [array objectAtIndex:section];
    self.titleLabel.text = [sectionDic objectForKey:@"chapterName"];
    NSDictionary *dic = [array objectAtIndex:section];
    //点击标题变换图片
    if (sectionStatus) {
        //章节添加横线，选中加阴影
        //直接取出datasource的section,检查返回数据中是否有key = @"sub"
        if ([dic.allKeys indexOfObject:@"sub"] != NSNotFound) {
            self.imageView.image = [UIImage imageNamed:@"一级减号"];
            [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
        } else {
            self.imageView.image = [UIImage imageNamed:@"一级圆"];
            [self.imageView setContentMode:UIViewContentModeTop];
        }
    } else {
        if ([dic.allKeys indexOfObject:@"sub"] != NSNotFound) {
            self.imageView.image = [UIImage imageNamed:@"一级圆环加号"];
            [self.imageView setContentMode:UIViewContentModeTop];
        } else {
            self.imageView.image = [UIImage imageNamed:@"一级圆"];
            [self.imageView setContentMode:UIViewContentModeTop];
        }
    }
    
    self.button.tag = section;
    
}
@end
