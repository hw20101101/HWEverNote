//
//  HWHomeViewController.m
//  HWEverNote
//
//  Created by hw on 2016/12/8.
//  Copyright © 2016年 hwacdx. All rights reserved.
//

#define kCollectionViewCellIdentifier @"HWCollectionViewCell"
#define kTableViewCellIdentifier @"HWTableViewCell"


#import "HWHomeViewController.h"
#import "HWSetViewController.h"
#import "HWCollectionViewCell.h"
#import "HWCollectionHeaderView.h"

@interface HWHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation HWHomeViewController

static NSString *const headerId = @"headerId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;//为YES时，它会找view里的scrollView，并设置scrollView的contentInset为{64, 0, 0, 0}。如果你不想让scrollView的内容自动调整，将这个属性设为NO（默认值YES）。
    [self initNavigationItems];
    [self.view addSubview:self.collectionView];
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithObjects:@"笔记1:就快点发家乐福",@"笔记2:大范德萨发方法",@"笔记3:反对法反对法", nil];
    }
    return _dataSource;
}

- (void)initNavigationItems
{
    //left item
    UIImage *setItemImage = [UIImage imageNamed:@"Set"];
    UIBarButtonItem *setItem = [[UIBarButtonItem alloc] initWithImage:setItemImage style:UIBarButtonItemStylePlain target:self action:@selector(setItemAction)];
    self.navigationItem.leftBarButtonItem = setItem;
    
    //right item
    UIImage *syncItemImage = [UIImage imageNamed:@"Sync"];
    UIImage *searchItemImage = [UIImage imageNamed:@"Search"];
    UIBarButtonItem *syncItem = [[UIBarButtonItem alloc] initWithImage:syncItemImage style:UIBarButtonItemStylePlain target:self action:@selector(syncItemAction)];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithImage:searchItemImage style:UIBarButtonItemStylePlain target:self action:@selector(searchItemAction)];
    self.navigationItem.rightBarButtonItems = @[searchItem, syncItem];
}

- (void)setItemAction{
    
    HWSetViewController *setVC = [[HWSetViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:setVC];
    [self.navigationController presentViewController:nav animated:YES completion:^{ }];
}

- (void)syncItemAction{

}

- (void)searchItemAction{
    
}

#pragma mark - collectionView
- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(300, 40);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        [layout setHeaderReferenceSize:CGSizeMake(300, 40)];
        
        //设置cell之间的间距为0
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 66, 300, 480) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];        
        [_collectionView registerNib:[UINib nibWithNibName:@"HWCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kCollectionViewCellIdentifier];
        [_collectionView registerNib:[UINib nibWithNibName:@"HWCollectionHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    }
    return _collectionView;
}

- (void)createHeaderView{
    
    
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0 || section == 2 || section == 4) {
        return 0;
    } else {
        return 3;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellIdentifier forIndexPath:indexPath];

    if (indexPath.section == 1) {
        cell.iconView.hidden = YES;
        cell.infoLabel.hidden = YES;
        cell.titleLabel.text = self.dataSource[indexPath.row];
        cell.detailLabel.text = @"2016/12/09";
        [self createHeaderLineView:cell.contentView];
        
    } else if(indexPath.section == 3){
        cell.iconView.hidden = NO;
        cell.infoLabel.hidden = NO;
        cell.detailLabel.text = @"你共享了一条笔记";
        [self createHeaderLineView:cell.contentView];
    
    }
    
    return cell;
}

- (void)createHeaderLineView:(UIView *)superView{
    
    UIView *horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(10, 39.5f, 290, 0.5f)];
    horizontalLine.backgroundColor = [UIColor lightGrayColor];
    horizontalLine.alpha = 0.35;
    [superView addSubview:horizontalLine];
}

// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        
        HWCollectionHeaderView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        if(headerView == nil){
            headerView = [[HWCollectionHeaderView alloc] init];
        }
        
        if (indexPath.section == 0) {
            headerView.iconView.hidden = YES;
            headerView.titleLabel.hidden = YES;
            headerView.infoLabel.hidden = YES;
            headerView.backgroundColor = [UIColor yellowColor];
            
        } else if(indexPath.section == 1){
            headerView.titleLabel.text = @"笔记本";
            headerView.infoLabel.text = @"全部 7";
            
        } else if(indexPath.section == 3) {
            headerView.titleLabel.text = @"工作群聊";
            headerView.infoLabel.text = @"查看";
            
        } else if(indexPath.section == 4){
            headerView.iconView.hidden = YES;
            headerView.titleLabel.hidden = YES;
            headerView.infoLabel.hidden = YES;
            headerView.backgroundColor = [UIColor purpleColor];
        }
        
        UIView *horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5f, 300, 0.5f)];
        horizontalLine.backgroundColor = [UIColor lightGrayColor];
        horizontalLine.alpha = 0.35;
        [headerView addSubview:horizontalLine];
        return headerView;
    }
    
    return nil;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(300, 50);
//}


#pragma mark   定义每个 Section 的 margin ？//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 5, 0);
}


/*
 HWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellIdentifier forIndexPath:indexPath];
 
 switch (indexPath.row) {
 case 1:
 cell.iconView.image = [UIImage imageNamed:@"Camera"];
 cell.titleLabel.text = @"照片";
 break;
 case 2:
 cell.iconView.image = [UIImage imageNamed:@"Reminder"];
 cell.titleLabel.text = @"提醒";
 break;
 case 3:
 cell.iconView.image = [UIImage imageNamed:@"Checkbox"];
 cell.titleLabel.text = @"清单";
 break;
 case 4:
 cell.iconView.image = [UIImage imageNamed:@"Speaker"];
 cell.titleLabel.text = @"录音";
 break;
 
 default:
 break;
 }
 
 return cell;
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
