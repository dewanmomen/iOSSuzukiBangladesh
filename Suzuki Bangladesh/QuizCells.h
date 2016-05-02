//
//  QuizCells.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/9/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *question;
@end


@interface OptionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *option;

@property (weak, nonatomic) IBOutlet UILabel *optionButton;


@end