//
//  ChapterTableViewCell.m
//  TableViewCell多级展开
//
//  Created by xrh on 2017/10/23.
//  Copyright © 2017年 xrh. All rights reserved.
//

#import "ChapterTableViewCell.h"
#import "ThreeTreeModel.h"
#import "ThreeTreeTableViewCell.h"

@interface ChapterTableViewCell ()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic) ThreeTreeModel *model;

@end

@implementation ChapterTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.dataArray = [[NSMutableArray alloc] init];
        self.chapterIdArray = [[NSMutableArray alloc] init];
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(13, -8, 19, 64)];
        _chapterName2 = [[UILabel alloc] initWithFrame:CGRectMake(45, 8, 183, 21)];
        _chapterName2.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_imageView2];
        [self.contentView addSubview:_chapterName2];
        [self setupTableView];
        _model = [[ThreeTreeModel alloc] init];
    }
    return self;
}

- (void)setupTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 59, [UIScreen mainScreen].bounds.size.width, 1) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[ThreeTreeTableViewCell class] forCellReuseIdentifier:@"testCell"];
}

- (void)showTableView {
    [self.contentView addSubview:self.tableView];
}

- (void)hiddenTableView {
    [self.tableView removeFromSuperview];
}

- (void)configureCellWithModel:(ThreeTreeModel *)model
                 WithIndexPath:(NSIndexPath *)indexPath
                     WithArray:(NSArray *)dataArr {
    //防止数据重复，所以每次进来的时候的清空数据源
    [self.dataArray removeAllObjects];
    _model = model;
    NSDictionary *cellDic = dataArr[indexPath.row];
    self.chapterName2.text = [cellDic objectForKey:@"chapterName"];
    NSArray *array = model.pois;
    
    for (int i = 0; i < array.count; i++) {
        NSDictionary *dict = [array objectAtIndex:i];
        NSString *chapterId = dict[@"chapterID"];
        [self.chapterIdArray addObject:chapterId];
        if (indexPath.row == dataArr.count - 1) {
            if (i == array.count - 1) {
                [self.dataArray addObject:@{@"chapterName" : dict[@"chapterName"],@"isLast" : @YES}];
            } else {
                [self.dataArray addObject:@{@"chapterName" : dict[@"chapterName"],@"isLast" : @NO}];
            }
        } else {
            [self.dataArray addObject:@{@"chapterName" : dict[@"chapterName"],@"isLast" : @NO}];
        }
    }
    
    CGRect frame = self.tableView.frame;
    frame.size.height = 60*array.count;
    self.tableView.frame = frame;
    [self.tableView reloadData];
    [self loadImageViewDataWithModel:model indexPath:indexPath array:dataArr];
    
    if (model.isShow) {
        [self showTableView];
    }
    else {
        [self hiddenTableView];
    }
}

- (void)loadImageViewDataWithModel:(ThreeTreeModel *)model indexPath:(NSIndexPath *)indexPath array:(NSArray *)arr {
    
    if (indexPath.row == arr.count - 1) {
        if (model.pois.count == 0) {
            self.imageView2.image = [UIImage imageNamed:@"二级圆尾"];
        } else {
            if (!model.isShow) {
                self.imageView2.image = [UIImage imageNamed:@"二级圆环-尾加"];
            } else {
                self.imageView2.image = [UIImage imageNamed:@"三级圆环减"];
            }
        }
    } else {
        if (model.pois.count == 0) {
            self.imageView2.image = [UIImage imageNamed:@"zhongjian"];
        } else {
            if (!model.isShow) {
                self.imageView2.image = [UIImage imageNamed:@"二级加号"];
            } else {
                self.imageView2.image = [UIImage imageNamed:@"三级圆环减"];
            }
        }
    }
    [self.imageView2 setContentMode:UIViewContentModeScaleAspectFit];
}

#pragma mark -- UITableViewDelegate And TableViewDatasuce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ThreeTreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"testCell"];
    if (!cell) {
        cell = [[ThreeTreeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"testCell"];
    }
    [cell loadDataWithArray:self.dataArray IndexPath:indexPath];
    return cell;
}
@end
