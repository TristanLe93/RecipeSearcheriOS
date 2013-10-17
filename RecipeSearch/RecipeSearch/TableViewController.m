//
//  TableViewController.m
//  RecipeSearch
//
//  Created by Tristan on 13/10/13.
//  Copyright (c) 2013 Tristan. All rights reserved.
//

#import "TableViewController.h"
#import "XMLParser.h"
#import "Recipe.h"

static NSString *fileName = @"100results";
static NSInteger count = 10;

@interface TableViewController ()
@end

@implementation TableViewController
@synthesize recipes;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    recipes = [[NSMutableArray alloc] init];
    
    NSDate *parseStart = [NSDate date];
    
    // parse the xml files ten times
    for (int i = 1; i <= count; i++) {
        NSDate *startTime = [NSDate date];
    
        [self loadXmlFileAndParse:@"100results"];
        
        // draw parse execution time
        NSDate *endTime = [NSDate date];
        NSTimeInterval executionTime = [endTime timeIntervalSinceDate:startTime];
        NSLog(@"Parsing file : %d - Execution Time = %f", i, executionTime);
    }
    
    // draw total execution time
    NSDate *parseEnd = [NSDate date];
    NSTimeInterval totalParseTime = [parseEnd timeIntervalSinceDate:parseStart];
    NSLog(@"Total Parse Time = %f", totalParseTime);
}

// loads an xml file and parses it. Store the results in an array
- (void)loadXmlFileAndParse:(NSString *)fileName {
    NSURL *pathURL = [[NSBundle mainBundle] URLForResource:fileName withExtension:@"xml"];
    NSString *path = [pathURL path];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
    
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithData:data];
    XMLParser *parser = [[XMLParser alloc] initXMLParser];
    [nsXmlParser setDelegate:parser];
    
    // begin parsing
    [nsXmlParser parse];
    
    for (Recipe *recipe in parser.recipes) {
        [recipes addObject:recipe];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return recipes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RecipeNameCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [[recipes objectAtIndex:indexPath.row] title];
    
    return cell;
}

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
