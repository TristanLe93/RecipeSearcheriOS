//
//  TableViewController.m
//  RecipeSearch
//
//  Created by Tristan on 13/10/13.
//  Copyright (c) 2013 Tristan. All rights reserved.
//

#import "TableViewController.h"
#import "RecipeDetailsViewController.h"
#import "XMLParser.h"

@class Recipe;

static NSString *fileName = @"10000recipes";
static NSInteger count = 5;

@interface TableViewController ()
@end

@implementation TableViewController
@synthesize recipes;

#pragma mark - 
#pragma mark - Initalise and Load

// initialise TableViewController
- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

// parse the fxml iles when the view is loaded
- (void)viewDidLoad {
    [super viewDidLoad];
    
    recipes = [[NSMutableArray alloc] init];
    NSDate *parseStart = [NSDate date];
    
    NSURL *pathURL = [[NSBundle mainBundle] URLForResource:fileName withExtension:@"xml"];
    NSString *path = [pathURL path];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
    
    // parse the xml files
    for (int i = 1; i <= count; i++) {
        [self parseXml:data];
    }
    
    // display the total time taken
    NSDate *parseEnd = [NSDate date];
    NSTimeInterval totalParseTime = [parseEnd timeIntervalSinceDate:parseStart];
    NSLog(@"Total Parse Time = %f", totalParseTime);
    NSLog(@"Total Recipes: %lu", (unsigned long)recipes.count);
    
    [self.tableView reloadData];
}

// loads an xml file and parses it. Store the results in an array
- (void)parseXml:(NSData *)data {
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithData:data];
    XMLParser *parser = [[XMLParser alloc] initXMLParser];
    [nsXmlParser setDelegate:parser];
    [nsXmlParser parse];
    
    [recipes addObjectsFromArray:parser.recipes];
}

// Dispose of any resources that can be recreated.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark - Table view data source

// Return the number of rows in the section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return recipes.count;
}

// Update the tableviewcell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"RecipeNameCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // set the name of the recipe to the textlabel
    cell.textLabel.text = [[recipes objectAtIndex:indexPath.row] title];
    
    return cell;
}

#pragma mark -
#pragma mark - Navigation

// Get the new view controller using [segue destinationViewController].
// Pass the selected object to the new view controller.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    RecipeDetailsViewController *destination = segue.destinationViewController;
    destination.recipe = [recipes objectAtIndex:indexPath.row];
}

@end
