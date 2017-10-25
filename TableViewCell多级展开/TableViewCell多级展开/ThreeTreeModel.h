//
//  ThreeTreeModel.h
//  TableViewCell多级展开
//
//  Created by xrh on 2017/10/23.
//  Copyright © 2017年 xrh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThreeTreeModel : NSObject

@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, strong) NSArray *pois;

/**
 *  模型数据
 */
-(instancetype)initWithDic:(NSDictionary *)info;

@end
