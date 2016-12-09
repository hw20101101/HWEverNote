//
//  HWCollectionViewCell.h
//  HWEverNote
//
//  Created by hw on 2016/12/8.
//  Copyright © 2016年 hwacdx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end
