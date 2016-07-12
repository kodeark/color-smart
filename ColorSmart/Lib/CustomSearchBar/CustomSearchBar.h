//
//  CustomSearchBar.h

#import <UIKit/UIKit.h>

@protocol CustomSearchBarDelegate;

@interface CustomSearchBar : UIView

//Wrappers around the Textfield subview
@property (nonatomic) NSString *text;
@property (nonatomic) UIFont *font;
@property (nonatomic) NSString *placeholder;

//The text field subview
@property (nonatomic) UITextField *textField;

@property (nonatomic, weak) id <CustomSearchBarDelegate> delegate;

@end

@protocol CustomSearchBarDelegate <NSObject>

@optional
- (void)searchBarClearButtonClicked:(CustomSearchBar *)searchBar;
- (void)searchBarSearchButtonClicked:(CustomSearchBar *)searchBar;

- (BOOL)searchBarShouldBeginEditing:(CustomSearchBar *)searchBar;
- (void)searchBarTextDidBeginEditing:(CustomSearchBar *)searchBar;
- (void)searchBarTextDidEndEditing:(CustomSearchBar *)searchBar;

- (void)searchBar:(CustomSearchBar *)searchBar textDidChange:(NSString *)searchText;
@end

//A rounded view that makes up the background of the search bar.
@interface CustomRoundedView : UIView
@end
