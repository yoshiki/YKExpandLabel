//
//  YKExpandLabel.m
//  YKExpandLabel
//
//  Created by Yoshiki Kurihara on 2013/07/11.
//  Copyright (c) 2013年 Yoshiki Kurihara. All rights reserved.
//

#import "YKExpandLabel.h"

@interface YKExpandLabel ()

@property (strong, nonatomic) UIButton *moreButton;
@property (strong, nonatomic) NSString *fullText;
@property (strong, nonatomic) NSString *moreText;

@end

@implementation YKExpandLabel

- (id)initWithFrame:(CGRect)frame
      numberOfLines:(NSInteger)numberOfLines
           moreText:(NSString *)moreText {
    
    self = [super initWithFrame:frame];
    if (self) {
        _moreText = moreText;
        _ellipsisString = @"\u2026"; // Unicode Character 'HORIZONTAL ELLIPSIS' (U+2026)
        
        self.numberOfLines = numberOfLines;
        self.userInteractionEnabled = YES;
        
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_moreButton setBackgroundColor:[UIColor clearColor]];
        [_moreButton addTarget:self action:@selector(expand) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_moreButton];
    }
    return self;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    _moreButton.titleLabel.font = [UIFont boldSystemFontOfSize:font.pointSize];
}

- (void)setTextColor:(UIColor *)textColor {
    [super setTextColor:textColor];
    _moreButton.titleLabel.textColor = textColor;
}

- (void)setFullText:(NSString *)fullText {
    _fullText = fullText;
    
    if ([self numberOfLinesForText:_fullText] > self.numberOfLines) {
        NSString *ellipsisAndMoreText = [NSString stringWithFormat:@"%@ %@", _ellipsisString, _moreText];
        NSMutableString *string = [[fullText stringByAppendingString:ellipsisAndMoreText] mutableCopy];
        NSRange range = NSMakeRange(string.length - (ellipsisAndMoreText.length + 1), 1);
        
        while ([self numberOfLinesForText:string] > self.numberOfLines) {
            [string deleteCharactersInRange:range];
            range.location--;
        }
        self.text = [string stringByReplacingCharactersInRange:range withString:@""];
        self.frame = CGRectMake(self.frame.origin.x,
                                self.frame.origin.y,
                                self.frame.size.width,
                                [self heightForLetter] * self.numberOfLines);
        
        CGSize moreButtonSize = [_moreText sizeWithFont:self.font
                                      constrainedToSize:CGSizeMake(CGFLOAT_MAX, [self heightForLetter])];
        CGRect moreButtonFrame = _moreButton.frame;
        moreButtonFrame.size = moreButtonSize;
        _moreButton.frame = moreButtonFrame;
    } else {
        self.text = fullText;
        [self expand];
    }
}

- (NSUInteger)numberOfLinesForText:(NSString *)text {
    CGFloat lineHeight = [self heightForLetter];
    CGFloat height = [text sizeWithFont:self.font
                      constrainedToSize:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX)
                          lineBreakMode:self.lineBreakMode].height;
    return (NSUInteger)(height/lineHeight);
}

- (CGFloat)heightForLetter {
    return [@"A" sizeWithFont:self.font].height;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = _moreButton.frame;
    frame.origin.x = CGRectGetWidth(self.frame) - CGRectGetWidth(_moreButton.frame);
    frame.origin.y = CGRectGetHeight(self.frame) - CGRectGetHeight(_moreButton.frame);
    _moreButton.frame = frame;
}

- (void)expand {
    _moreButton.hidden = YES;
    self.numberOfLines = 0;
    self.text = _fullText;
    CGRect frame = self.frame;
    frame.size = [self sizeThatFits:CGSizeMake(CGRectGetWidth(self.frame), CGFLOAT_MAX)];
    self.frame = frame;
}

@end
