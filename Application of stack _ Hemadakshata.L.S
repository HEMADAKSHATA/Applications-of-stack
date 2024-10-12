#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node {
    char data[50];
    struct Node* next;
} Node;

typedef struct Stack {
    Node* top;
} Stack;

void push(Stack* stack, char* data) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    strcpy(newNode->data, data);
    newNode->next = stack->top;
    stack->top = newNode;
}

char* pop(Stack* stack) {
    if (stack->top == NULL) {
        return NULL;
    }
    Node* temp = stack->top;
    stack->top = stack->top->next;
    char* popped = temp->data;
    free(temp);
    return popped;
}

int is_empty(Stack* stack) {
    return stack->top == NULL;
}

void undo(Stack* undoStack, Stack* redoStack) {
    if (is_empty(undoStack)) {
        printf("Nothing to undo\n");
    } else {
        char* action = pop(undoStack);
        push(redoStack, action);
        printf("Undone: %s\n", action);
    }
}

void redo(Stack* redoStack, Stack* undoStack) {
    if (is_empty(redoStack)) {
        printf("Nothing to redo\n");
    } else {
        char* action = pop(redoStack);
        push(undoStack, action);
        printf("Redone: %s\n", action);
    }
}

int main() {
    Stack undoStack = { NULL };
    Stack redoStack = { NULL };

    push(&undoStack, "Hello");
    push(&undoStack, "World");

    undo(&undoStack, &redoStack);  // Output: Undone: World
    redo(&redoStack, &undoStack);  // Output: Redone: World

    return 0;
}
