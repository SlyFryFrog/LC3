#include <stdio.h>
#include <stdlib.h>

typedef struct node
{
    int value;
    struct node *next;
} node_t;

void printList(node_t **head);
void addValue(node_t **head, int added);
void removeValue(node_t **head, int removed);

int main()
{
    node_t *head;
    
    char selection = 's';
    
    while(selection != 'q')
    {
        printf("Available options:\n");
        printf("p - Print linked list\n");
        printf("a - Add value to linked list\n");
        printf("r - Remove value from linked list\n");
        printf("q - Quit\n");
        printf("Choose an option: ");
        scanf(" %c", &selection);
        
        if(selection == 'p')
        {
            printList(&head);
        }
        else if(selection == 'a')
        {
            int a = 0;
            printf("Type a number to add: ");
            scanf("%d", &a);
            addValue(&head, a);
        }
        else if(selection == 'r')
        {
            int r = 0;
            printf("Type a number to remove: ");
            scanf("%d", &r);
            removeValue(&head, r);
        }
    }
}

void printList(node_t **head)
{
    node_t *current = (*head);
    while(current != 0)
    {
        printf("%d", current->value);
        current = current->next;
        
        if(current != 0)
        {
            printf(" -> ");
        }
    }
    
    printf("\n");
    
    return;
}

void addValue(node_t **head, int added)
{
    node_t *current = (*head);
    
    if((*head) == 0)
    {
        (*head) = (node_t *) malloc(sizeof(node_t));
        (*head)->value = added;
        return;
    }
    
    while(current != 0)
    {
        if(current->next == 0)
        {
            current->next = (node_t *) malloc(sizeof(node_t));
            current->next->value = added;
            return;
        }
        
        current = current->next;
    }
    
    return;
}

void removeValue(node_t **head, int removed)
{
    node_t *prev = (*head);
    
    if((*head)->value == removed)
    {
        (*head) = (*head)->next;
        free(prev);
        return;
    }
    
    node_t *current = (*head)->next;
    
    while(current != 0)
    {
        if(current->value == removed)
        {
            prev->next = current->next;
            free(current);
            current = prev->next;
        }
        
        prev = current;
        current = current->next;
    }
    
    return;
}