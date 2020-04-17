# Cup of Sugar (Back End)
## Contributors: Carleigh Crockett & Lain McGrath

## About
Cup of Sugar is an app that allows neighbors to communicate about items they have to lend or would like to borrow. Users can choose to login as a Lender or Borrower. As a Borrower, neighbors can post item requests for items they need or browse available items. As a Lender, neighbors can post items they have to lend or browse item requests in their neighborhood.

## Technologies Used
- Rails
- Graphql
- Postgres

### Models and Types

Each type corresponds to a model. Each type has a select amount of attributes that are allowed as argument and return fields. You must update the type if you wish to add additional arguments or values returned. Please note that both the postings and messages tables are self-referencing.

Category
Item
User
Posting
Message

### Queries 
#### Categories 
Returns all categories:
```
query {
  getAllCategories{
    name
  }
}
```
#### Items 
Returns all items: 
```
query {
  getAllItems {
    name
    quantity
    available
    description
    measurement
    timeDuration
    postingId
    category {
      name
    }
  }
}
```
Returns all items associated with a specific category: 
```
query {
  getAllItemsInCategory(name: "Lawn Care") {
    name
    quantity
    timeDuration
    measurement
    description
    available
    postingId
  }
}
```
Returns all items by name: 
```
query {
  getAllItemsByName(itemName: "Mower") {
    postingId
    name
    quantity
    timeDuration
    available
  }
}
```
#### Postings
##### All of these endpoints return the title of a posting and the item associated with said posting.

##### User logged in as a lender
Returns all postings a user currently has and item available to lend: 
```
query {
  itemsUserOfferedToLend {
    name
    quantity
    available
    description
    measurement
    timeDuration
    posting {
      id
      title
    }
  }
}
``` 
Returns all postings in which the lender's items have been marked as borrowed:
```
query {
  itemsUserHasLent {
    name
    quantity
    available
    description
    measurement
    timeDuration
    posting {
      id
      title
    }
  }
}
```
##### User logged in as a borrower
Returns a list of all postings: 
```
query {
  itemsUserLookingToBorrow {
    name
    quantity
    available
    description
    measurement
    timeDuration
    posting {
      id
      title
    }
  }
}
```
Returns a list of all open borrow requests (those which have not been responded to by a lender):
```
query {
  itemsUserRequestedToBorrow {
    name
    quantity
    available
    description
    measurement
    timeDuration
    posting {
      id
      title
    }
    category {
      name
    }
  }
}
```
Returns a list of items which the borrower currently has in their possession (lender has responded to this request):
```
query {
  itemsUserHasBorrowed {
    name
    quantity
    available
    description
    measurement
    timeDuration
    posting {
      id
      title
    }
  }
}
```
#### Messages
Returns an outbox of messages sent to other users:
```
query {
  userOutbox {
    title
    body
    recipient {
      firstName
      email
    }
  }
}
```
Returns an inbox of messages received from others:
```
query {
  userInbox {
    title
    body
    sender {
      firstName
      email
    }
  }
}
```

### Mutations 
#### Items
Item availability can be toggled when a user takes the action of borrowing or lending an item:
``` 
mutation {
  item: updateItemAvailability(
    input: {
      id: "#{@mop.id}"
      available: true
      name: "#{@mop.name}"
    }
  )
  {
    id
    available
    name
  }
}
```
#### Users 
User login: 
``` 
mutation {
  user: userLogin(
    input: {
       credentials: {
        email: "carole@tigers"
        password: "password"
      }
    }
  )
  {
    token
      user {
        id
      }
    }
  }
```
#### Postings 
##### Borrow Postings
Posting can be created for a user requesting items which cannot be returned:
```
mutation {
  posting: createPosting(
    input: {
      postingType: "borrow"
      title: "Looking to borrow"
      categoryName: "#{@food.name}"
      name: "Butter"
      description: "It's butter."
      quantity: "8.0"
      measurement: "oz"
    }
  ) {
    name
    description
    quantity
    measurement
  }
}
```
Posting can be created for a user requesting items which can be returned:
``` 
mutation {
  posting: createPosting(
    input: {
      title: "Looking to borrow"
      postingType: "borrow"
      categoryName: "#{@gardening.name}"
      name: "trowel"
      description: "What is a trowel? Why does it exist?"
      quantity: "4.0"
      timeDuration: "days"
    }
  ) {
    name
    description
    quantity
    timeDuration
  }
}
```
##### Lend Postings
The only real change to note in these mutations is the postingType

Posting can be created for a user lending items which cannot be returned:
```
mutation {
  posting: createPosting(
    input: {
      postingType: "lend"
      title: "Looking to lend"
      categoryName: "#{@food.name}"
      name: "Butter"
      description: "It's butter."
      quantity: "8.0"
      measurement: "oz"
    }
  ) {
    name
    description
    quantity
    measurement
  }
}
```
Posting can be created for a user lending items which can be returned:
```
mutation {
  posting: createPosting(
    input: {
      title: "Looking to lend"
      postingType: "lend"
      categoryName: "#{@gardening.name}"
      name: "trowel"
      description: "What are even?"
      quantity: "4.0"
      timeDuration: "days"
    }
  ) {
    name
    description
    quantity
    timeDuration
  }
}
```
Posting can be deleted:
```
mutation {
  posting: deletePosting(
    input: {
      id: #{@posting1.id}
    }
  )
  {
    title
  }
}
``` 
#### Messages
User can send a message: 
```
mutation {
  message: sendMessage(
    input: {
      title: "Borrowing your drill"
      body: "Thanks so much for letting me borrow your drill. Can I pick it up on Saturday?"
      recipientEmail: "#{@user1.email}"
    }
  )
  {
    id
    title
    body
  }
 }
```

#### Authorization and headers
In order to access and endoints, a user must first successfuly log in. Once a user's credentials are confirmed, a token is returned to the frontend. This token must be included as an `authorization` header. Additionally after credentials are confirmed, the backend has global access to the current user by using `context[:current_user]` in all mutations and queries. 
