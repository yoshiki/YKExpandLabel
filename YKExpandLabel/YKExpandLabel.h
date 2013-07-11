//
//  YKExpandLabel.h
//  YKExpandLabel
//
//  Created by Yoshiki Kurihara on 2013/07/11.
//  Copyright (c) 2013年 Yoshiki Kurihara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKExpandLabel : UILabel

@property (strong, nonatomic) NSString *ellipsisString;

- (id)initWithFrame:(CGRect)frame
      numberOfLines:(NSInteger)numberOfLines
           moreText:(NSString *)moreText;

- (void)setFullText:(NSString *)fullText;

@end
