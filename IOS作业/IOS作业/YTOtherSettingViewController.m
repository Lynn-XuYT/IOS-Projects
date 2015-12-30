//
//  YTOtherSettingViewController.m
//  IOS作业
//
//  Created by Lynn on 15/12/29.
//  Copyright © 2015年 xu. All rights reserved.
//

#import "YTOtherSettingViewController.h"
#import "YTOtherSettingCell.h"
#import "YTSettingItem.h"
#import "YTSettingGroup.h"
@interface YTOtherSettingViewController ()

@end

@implementation YTOtherSettingViewController

- (void)setupGroup
{
    YTSettingItem *a1 = [YTSettingItem itemWithTitle:@"声音" destVcClass:nil];
    YTSettingItem *a2 = [YTSettingItem itemWithTitle:@"消息" destVcClass:nil];
    YTSettingGroup *group = [[YTSettingGroup alloc] init];
    group.items = @[a1, a2];
    [self.data addObject:group];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupGroup];
}

#pragma mark - Table view data source


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    YTOtherSettingCell *cell = [YTOtherSettingCell cellWithTableView:tableView];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


@end
