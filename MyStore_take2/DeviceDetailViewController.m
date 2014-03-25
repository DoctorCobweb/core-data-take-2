//
//  DeviceDetailViewController.m
//  MyStore_take2
//
//  Created by andre on 25/03/2014.
//  Copyright (c) 2014 andre trosky. All rights reserved.
//

#import "DeviceDetailViewController.h"

@interface DeviceDetailViewController ()

@end

@implementation DeviceDetailViewController

@synthesize device;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    if (device) {
        [self.nameTextField setText:[device valueForKey:@"name"]];
        [self.versionTextField setText:[device valueForKey:@"version"]];
        [self.companyTextField setText:[device valueForKey:@"company"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];

    if (device) {
        // Update existing device
        [device setValue:self.nameTextField.text forKey:@"name"];
        [device setValue:self.versionTextField.text forKey:@"version"];
        [device setValue:self.companyTextField.text forKey:@"company"];
        
    } else {
        // Create a new managed object
        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
        [newDevice setValue:self.nameTextField.text forKey:@"name"];
        [newDevice setValue:self.versionTextField.text forKey:@"version"];
        [newDevice setValue:self.companyTextField.text forKey:@"company"];
    }
    
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    NSLog(@"yoyoyoy");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
