//
//  ViewController.m
//  TableViewCell多级展开
//
//  Created by xrh on 2017/10/23.
//  Copyright © 2017年 xrh. All rights reserved.
//

#import "ViewController.h"
#import "Common.h"
#import "ThreeTreeModel.h"
#import "ChapterHeader.h"
#import "ChapterTableViewCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource,ChapterHeaderDelegate> {
    NSInteger currentSection;
    NSInteger currentRow;
}

//tableView 显示的数据
@property (nonatomic, strong) NSArray *dataSource;
//标记section的打开状态
@property (nonatomic, strong) NSMutableArray *sectionOpen;

@property (nonatomic, strong) NSMutableDictionary *cellOpen;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.cellOpen = [[NSMutableDictionary alloc] init];
    [self getDataFrameJson];
}

- (void)getDataFrameJson {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"json" ofType:nil];
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    self.dataSource = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    NSLog(@"self.dataSource == %@, count == %ld",self.dataSource,self.dataSource.count);
    
    //段的开关状态 (默认是关闭状态)
    self.sectionOpen = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < self.dataSource.count; i++) {
        [self.sectionOpen addObject:@0];
    }
    
    for (NSDictionary *dict in self.dataSource) {
        NSArray *arr = [dict objectForKey:@"sub"];
        for (NSDictionary *dic in arr) {
            NSString *key = [NSString stringWithFormat:@"%@",dic[@"chapterID"]];
            ThreeTreeModel *model = [[ThreeTreeModel alloc] initWithDic:dic];
            model.isShow = NO;
            [self.cellOpen setObject:model forKey:key];
        }
    }
    
    [_tableView reloadData];
    NSLog(@"self.cellOpne == %@",self.cellOpen);
}


#pragma mark -- tableViewDatasuce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BOOL sectionStatus = [self.sectionOpen[section] boolValue];
    if (sectionStatus) {
        
        //多少行cell
        NSDictionary *sectionDic = self.dataSource[section];
        //section决定cell的数据
        NSDictionary *cellArray = [sectionDic objectForKey:@"sub"];
        return cellArray.count;
    } else {
        
        //section是收起状态的时候
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    ChapterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[ChapterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.contentView.backgroundColor=[UIColor whiteColor];
    NSDictionary *sectionDic = self.dataSource[indexPath.section];
    NSArray *cellArray = sectionDic[@"sub"];
    
    //cell当前的数据
    NSDictionary *cellData = cellArray[indexPath.row];
    NSString *key = [NSString stringWithFormat:@"%@", cellData[@"chapterID"]];
    ThreeTreeModel *chapterModel = [self.cellOpen valueForKey:key];
    [cell configureCellWithModel:chapterModel WithIndexPath:indexPath WithArray:cellArray];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *sectionDic = self.dataSource[indexPath.section];
    NSArray *cellArray = sectionDic[@"sub"];
    
    //cell的当前数据
    NSDictionary *cellData = cellArray[indexPath.row];
    NSString *key = [NSString stringWithFormat:@"%@",cellData[@"chapterID"]];
    ThreeTreeModel *model = [self.cellOpen valueForKey:key];
    if (model.isShow) {
        return (model.pois.count + 1) * 60;
    } else {
        return 60;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ChapterHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"ChapterHeader" owner:self options:nil] lastObject];
    header.delegate = self;
    BOOL sectionStatus = [self.sectionOpen[section] boolValue];
    [header loadDataWithArray:self.dataSource Section:section SectionStatus:sectionStatus];
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    currentRow = indexPath.row;
    
    NSDictionary *sectionDic = self.dataSource[indexPath.section];
    NSArray *cellArr = [sectionDic objectForKey:@"sub"];
    
    //cell当前的数据，做打开关闭判断使用
    NSDictionary *cellDic = [cellArr objectAtIndex:indexPath.row];
    NSString *key = [NSString stringWithFormat:@"%@",[cellDic objectForKey:@"chapterID"]];
    ThreeTreeModel *model = [self.cellOpen valueForKey:key];
    
    model.isShow = ! model.isShow;
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark -- 段头点击事件代理
- (void)didtouchButtonEvent:(UIButton *)button {
    currentSection = button.tag;
    
    //tableView收起，局部刷新
    NSNumber *sectionStatus = self.sectionOpen[button.tag];
    BOOL newSection = ![sectionStatus boolValue];
    [self.sectionOpen replaceObjectAtIndex:[button tag] withObject:[NSNumber numberWithBool:newSection]];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:[button tag]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
