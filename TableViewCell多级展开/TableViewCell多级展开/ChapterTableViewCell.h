//
//  ChapterTableViewCell.h
//  TableViewCell多级展开
//
//  Created by xrh on 2017/10/23.
//  Copyright © 2017年 xrh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ThreeTreeModel;
@class ChapterExerciseViewController;
@interface ChapterTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UILabel *chapterName2;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *chapterIdArray;

@property (nonatomic, strong) ChapterExerciseViewController *chapterVC;

/**
 * cell的赋值方法
 
 * <#model#>  cell的数据模型
 * <#indexPath#> 当前cell的索引
 * <#dataArr#> 第二层数据中的数组
 */
- (void)configureCellWithModel:(ThreeTreeModel *)model
                 WithIndexPath:(NSIndexPath *)indexPath
                     WithArray:(NSArray *)dataArr;

- (void)showTableView;
- (void)hiddenTableView;

@end
