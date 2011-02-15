#include "defs.h"
#include "recordlist.h"
#define NULL (void*)0


<<<<<<< HEAD
typedef struct rnode recordnode;

=======
//typedef struct rnode recordnode;
/*
>>>>>>> 3b2cb5cc4164eaf76bfe2c78ef3f917709156f97
struct rnode
{
	struct record *rec;
	struct rnode *next;
};
*/
void add_record(struct rnode* rlist, struct record* re)
{
	struct rnode *cur = rlist;
	while(cur->next != NULL)
	{
		cur = cur->next;
	}
	
	struct rnode *newnode = (struct rnode*)kalloc();
	newnode->rec = re;
	newnode->next = NULL;
	cur->next = newnode;
}

int print_records(struct record *records, int num_records)
{
	struct rnode *cur = proc->recordlist;
	int count = 0;
	
	if (records != NULL)
	{
		while(cur->next != NULL)
		{
			if (count < num_records)
			{
				records[count] = *(cur->rec);
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
