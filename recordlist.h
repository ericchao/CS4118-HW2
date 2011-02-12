#include "record.h"
#define NULL (void*)0

/*
typedef struct rnode recordnode;

struct rnode
{
	struct record *rec;
	struct rnode *next;
};
*/

static void add_record(struct record* rlist, struct record* re)
{
	struct record *cur = rlist;
	while(cur->next != NULL)
	{
		cur = cur->next;
	}
	
	struct record *newnode = (struct record*)kalloc();
	newnode->type = re->type;
	newnode->value = re->value;
	newnode->next = NULL;
	cur->next = newnode;
}

static void print_records(struct record* rlist)
{
	struct record *cur = rlist;

	while(cur->next != NULL)
	{
		cprintf("%s: %s", cur->type, cur->value);
		cur = cur->next;
	}
	cprintf("%s: %s", cur->type, cur->value);

}
