//
//  CustomSearchBar.m


#import "CustomSearchBar.h"

#define kXMargin 12
#define kYMargin 4
#define kCornerRadius 10

@interface CustomSearchBar () <UITextFieldDelegate> {
    BOOL _cancelButtonHidden;
}
@property (nonatomic) UIButton *cancelButton;
@property (nonatomic) UIImageView *searchImageView;
@property (nonatomic) CustomRoundedView *backgroundView;

@property (nonatomic) UIImage *searchImage;

@end

@implementation CustomSearchBar

#pragma mark - Initializers

- (void)setDefaults {
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    NSUInteger boundsWidth = self.bounds.size.width;
    NSUInteger textFieldHeight = self.bounds.size.height - kYMargin;
    
    //Background Rounded White Image
    self.backgroundView = [[CustomRoundedView alloc] initWithFrame:CGRectMake(0.0, 0.0, boundsWidth , self.bounds.size.height)];
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:self.backgroundView];
    
    //Cancel Button
    self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 80, self.bounds.size.height)];
    [self.cancelButton setTitle:@"CLEAR" forState:UIControlStateNormal];
    self.cancelButton.titleLabel.textColor = [UIColor whiteColor];
    self.cancelButton.titleLabel.font = [UIFont fontWithName:@"OpenSans-Regular" size:10.0];
    self.cancelButton.backgroundColor = [UIColor colorWithRed:0.0 green:(189.0/255.0) blue:(159.0/255.0) alpha:1.0];
    self.cancelButton.layer.cornerRadius = kCornerRadius;
    self.cancelButton.layer.masksToBounds = true;
    self.cancelButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [self.cancelButton addTarget:self action:@selector(pressedClear:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.cancelButton];
    
    CGRect frame = self.cancelButton.frame;
    frame.origin.x = CGRectGetWidth(self.bounds) - CGRectGetWidth(self.cancelButton.bounds);
    self.cancelButton.frame = frame;
    
    //TextField
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(2*kXMargin , kYMargin, boundsWidth - CGRectGetWidth(self.cancelButton.bounds) - 2*kXMargin , textFieldHeight)];
    self.textField.delegate = self;
    self.textField.returnKeyType = UIReturnKeySearch;
    self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    UIFont *defaultFont = [UIFont fontWithName:@"OpenSans-Regular" size:10.0];
    self.textField.font = defaultFont;
    self.textField.textColor = [UIColor blackColor];
    self.textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:self.textField];
    
    //Listen to text changes
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextFieldTextDidChangeNotification object:self.textField];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setDefaults];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    
    CGRect newFrame = frame;
    frame = newFrame;
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaults];
    }
    return self;
}

- (id)init
{
    return [self initWithFrame:CGRectMake(10, 20, 300, 32)];
}

#pragma mark - Properties and actions

- (NSString *)text {
    return self.textField.text;
}
- (void)setText:(NSString *)text {
    self.textField.text = text;
}
- (NSString *)placeholder {
    return self.textField.placeholder;
}
- (void)setPlaceholder:(NSString *)placeholder {
    self.textField.placeholder = placeholder;
}

- (UIFont *)font {
    return self.textField.font;
}
- (void)setFont:(UIFont *)font {
    self.textField.font = font;
}

- (void)pressedClear: (id)sender {
    
    self.textField.text = @"";
    [self.textField resignFirstResponder];
    
    if ([self.delegate respondsToSelector:@selector(searchBarClearButtonClicked:)])
    [self.delegate searchBarClearButtonClicked:self];
}

#pragma mark - Text Delegate

- (void)textChanged: (id)sender {
    if ([self.delegate respondsToSelector:@selector(searchBar:textDidChange:)])
        [self.delegate searchBar:self textDidChange:self.text];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)])
        return [self.delegate searchBarShouldBeginEditing:self];
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)])
        [self.delegate searchBarTextDidBeginEditing:self];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)])
        [self.delegate searchBarTextDidEndEditing:self];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)])
        [self.delegate searchBarSearchButtonClicked:self];
    
    return YES;
}

- (BOOL)isFirstResponder {
    return [self.textField isFirstResponder];
}
- (BOOL)becomeFirstResponder {
    return [self.textField becomeFirstResponder];
}
- (BOOL)resignFirstResponder {
    [self.textField resignFirstResponder];
    return YES;
}

#pragma mark - Cleanup

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

@implementation CustomRoundedView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(contextRef, [UIColor colorWithRed:(170.0/255.0) green:(179.0/255.0) blue:(188.0/255.0) alpha:1.0].CGColor);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:kCornerRadius];
    [path stroke];
}

@end
