//
//  ThreeTreeTableViewCell.h
//  TableViewCell多级展开
//
//  Created by xrh on 2017/10/23.
//  Copyright © 2017年 xrh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreeTreeTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView *image;
@property (nonatomic, strong) UILabel *label;

- (void)loadDataWithArray:(NSArray *)array IndexPath:(NSIndexPath *)indexPath;

@end
