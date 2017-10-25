//
//  ThreeTreeTableViewCell.m
//  TableViewCell多级展开
//
//  Created by xrh on 2017/10/23.
//  Copyright © 2017年 xrh. All rights reserved.
//

#import "ThreeTreeTableViewCell.h"

@implementation ThreeTreeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(13, 0, 19, 60)];
        _label = [[UILabel alloc] initWithFrame:CGRectMake(45, 8, 183, 21)];
        _label.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_image];
        [self.contentView addSubview:_label];
    }
    return self;
}

- (void)loadDataWithArray:(NSArray *)array IndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = array[indexPath.row];
    _label.text = [dict objectForKey:@"chapterName"];
    BOOL isLast = [[dict objectForKey:@"isLast"] boolValue];
    //判断cell的位置选择折叠图片
    [self.image setContentMode:UIViewContentModeScaleAspectFit];
    if (isLast == YES) {
        self.image.image = [UIImage imageNamed:@"三级级圆环-尾"];
    } else {
        self.image.image = [UIImage imageNamed:@"三级圆环"];
    }
}


@end
