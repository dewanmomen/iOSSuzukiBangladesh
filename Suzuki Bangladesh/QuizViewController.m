//
//  QuizViewController.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/9/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "QuizViewController.h"
#import "QuizCells.h"

#import "APIURLsNdKeys.h"
#import "GlobalInstance.h"
#import "NSDictionary+QuizData.h"

#import "MBProgressHUD.h"

#import "AFHTTPSessionManager.h"
#import "TSMessage.h"
#import "UIBarButtonItem+Badge.h"
#import "NotificationListViewController.h"

@implementation QuizViewController{
    int count;
    int seconds;
    int timeForEachQuestion;
    NSArray* quizData;
    NSTimer* updateQuestionTimer;
    NSTimer* updateSecondsTimer;
    
    NSIndexPath* selectedIndexpath;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self getQuizData];
    timeForEachQuestion = 10;
    seconds = timeForEachQuestion;
    count = 0;
    //UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]];
    [self setUpTheNavBar];
    
    [self getQuizData];
}

- (void)setUpTheNavBar{
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:font_suzuki_regular size:21]}];
    
    [self.sideBarMenu setTitleTextAttributes:@{
                                               NSFontAttributeName: [UIFont fontWithName:font_font_awesome_yay size:18.0],
                                               NSForegroundColorAttributeName: [UIColor whiteColor]
                                               } forState:UIControlStateNormal];
    [self.sideBarMenu setTitle:@"\uf0c9"];
    
    [self.navBarNotifButton setTitleTextAttributes:@{
                                                     NSFontAttributeName: [UIFont fontWithName:font_font_awesome_yay size:18.0],
                                                     NSForegroundColorAttributeName: [UIColor whiteColor]
                                                     } forState:UIControlStateNormal];
    [self.navBarNotifButton setTitle:@"\uf0a2"];
    
    [self.navBarMapButton setTitleTextAttributes:@{
                                                   NSFontAttributeName: [UIFont fontWithName:font_font_awesome_yay size:18.0],
                                                   NSForegroundColorAttributeName: [UIColor whiteColor]
                                                   } forState:UIControlStateNormal];
    [self.navBarMapButton setTitle:@"\uf041"];
    
    self.navBarNotifButton.badgeBGColor = [UIColor colorWithRed:253/255.0 green:176/255.0 blue:15/255.0 alpha:1.0];
    self.navBarNotifButton.badgeTextColor = [UIColor whiteColor];
    self.navBarNotifButton.badgeFont = [UIFont fontWithName:font_suzuki_regular size:11.0];
    self.navBarNotifButton.badgePadding = 1.0;
    self.navBarNotifButton.badgeOriginX = 12.0;
    self.navBarNotifButton.badgeOriginY = 2.0;
    self.navBarNotifButton.badgeValue = @"14";
    
}

-(void)reloadQuizTable{
    [self.quizTable reloadData];
    
}

- (void)updateTimer{
    seconds -=1;
    [self.timer setText:[NSString stringWithFormat:@"Time left for this question: %02d",seconds]];
}

- (void)updateQuestion{
    NSLog(@"inside timer");
    if (quizData.count - count > 1) {
        count+=1;
        [UIView transitionWithView:self.quizTable
                          duration:0.5
                           options:UIViewAnimationOptionTransitionCurlUp//UIViewAnimationOptionTransitionFlipFromTop
                        animations:^{
                            //[self.quizTable deselectRowAtIndexPath:selectedIndexpath animated:YES];
                            [self.quizTable reloadData];
                            seconds = timeForEachQuestion;
                        }
                        completion:NULL];
    }
    else{
        [updateQuestionTimer invalidate];
        [updateSecondsTimer invalidate];
        updateQuestionTimer = nil;
        updateSecondsTimer = nil;
        [self.timer setText:@"Quiz Finished ! Thank You."];
        self.quizTable.allowsSelection = NO;
        //[self.quizTable setHidden:YES];
        [self.nextButton setHidden:YES];
        
    }
}

-(void)setTimer{
    updateQuestionTimer = [NSTimer scheduledTimerWithTimeInterval:timeForEachQuestion target:self selector:@selector(updateQuestion) userInfo:nil repeats:YES];
}

-(void)setSeconds{
    updateSecondsTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
}

- (void) getQuizData{
    NSDictionary *parameters = @{key_getQuiz_authKey: [GlobalInstance sharedInstance].auth_key};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [manager POST:[APIURLsNdKeys getQuizDataURL] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [[GlobalInstance sharedInstance] setQuizJSON:responseObject];
        
        quizData = [[GlobalInstance sharedInstance].quizJSON quizes];
        
        [self.quizTile setText:[[GlobalInstance sharedInstance].quizJSON title]];
        
        self.quizTable.delegate = self;
        self.quizTable.dataSource = self;
        
        [self.timer setText:[NSString stringWithFormat:@"Time left for this question: %02d",seconds]];
        
        [UIView transitionWithView:self.quizTable
                          duration:0.5
                           options:UIViewAnimationOptionTransitionCurlUp
                        animations:^{ [self.quizTable reloadData]; seconds = timeForEachQuestion;}
                        completion:NULL];
        
        [self setTimer];
        [self setSeconds];
        
        //NSLog(@"the returned array %i", [quizArray count]);
        //QuizQuestion* qq = [quizData objectAtIndex:1];
        //QuizQuestion* qq2 = [quizData objectAtIndex:2];
       // NSLog(@"question title: %@ and %@", qq.question, qq2.question);
        //QuizOption* qo = [qq.options objectAtIndex:1];
        //NSLog(@"question: %@", qq.question);
        //NSLog(@"first option: %@", qo.option);
        //[MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //[MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [TSMessage showNotificationInViewController:self
                                              title:@"Error Retrieving Data"
                                           subtitle:[error localizedDescription]
                                               type:TSMessageNotificationTypeError];
    }];
    
}

- (IBAction)sideBarButtonMenuShow:(id)sender {
    
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
    
}

//- (IBAction)toggle:(id)sender {
//    [UIView transitionWithView:self.label duration:1.0f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//        self.label.text = @"Nice nice!" ; @"Well done!";
//    } completion:nil];
//    
////    [UIView beginAnimations:@"animateText" context:nil];
////    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
////    [UIView setAnimationDuration:1.0f];
////    [self.label setAlpha:0];
////    [self.label setText:@"New Text"];
////     [self.label setAlpha:1];
////     [UIView commitAnimations];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((QuizQuestion*)[quizData objectAtIndex:count]).options.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"inside cellforrowatindex");
    NSLog(@"from cellforrowatindex %i", count);
    QuizQuestion* qq = [quizData objectAtIndex:count];
    if (indexPath.row == 0) {
        
        NSString *CellIdentifier = @"quizQuesCell";
        QuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        [cell.question setText:qq.question];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selected = NO;
        return cell;
        
    } else {
        NSString *CellIdentifier = @"optionCell";
        OptionCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        QuizOption* qo = [qq.options objectAtIndex:indexPath.row -1];
        [cell.option setText:qo.option];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selected = NO;
        [cell.optionButton setText:@"\u26AA"];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath   *)indexPath
{
    if(indexPath.row != 0){
        OptionCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.optionButton setText:@"\u26AB"];
        //[tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        //[tableView deselectRowAtIndexPath:selectedIndexpath animated:YES];
        if(indexPath != selectedIndexpath){
        cell = [tableView cellForRowAtIndexPath:selectedIndexpath];
        [cell.optionButton setText:@"\u26AA"];
        }
        selectedIndexpath = indexPath;
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}

- (IBAction)nextButtonAction:(id)sender {
    [self updateQuestion];
    [updateQuestionTimer invalidate];
    [self setTimer];
    //seconds = timeForEachQuestion;
}



- (IBAction)navBarNotifButtonAction:(id)sender {
    
    NotificationListViewController* notificationViewController = (NotificationListViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@ "notificationListScene"];
    [self.navigationController pushViewController:notificationViewController animated:YES];
}

- (IBAction)navBarMapAction:(id)sender {
}
@end
