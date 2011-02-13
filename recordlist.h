#include "record.h"
//#include "proc.h"
#define NULL (void*)0


typedef struct rnode recordnode;

static recordnode recordlist;

struct rnode
{
	struct record *rec;
	struct rnode *next;
};

static void add_record(recordnode* rlist, struct record* re)
{
	recordnode *cur = rlist;
	while(cur->next != NULL)
	{
		cur = cur->next;
	}
	
	recordnode *newnode = (recordnode*)kalloc();
	newnode->rec = re;
	newnode->next = NULL;
	cur->next = newnode;
}

static int print_records(struct record *records, int num_records)
{
	recordnode *cur = proc->recordlist;
	int count = 0;
	
	if (records != NULL)
	{
		while(cur->next != NULL)
		{
			if (count < num_records)
			{
				records[count] = cur->rec;
				cur = cur->next;
				count++;
			}
			else
				break;
		}
	}
	else
	{
		while (cur->next != NULL)
		{
			count++;
		}
		count++;
	}
	return count;
}
