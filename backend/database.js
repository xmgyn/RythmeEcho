const { MongoClient } = require('mongodb');

const url = 'mongodb://localhost:27017';
const client = new MongoClient(url);

client.connect();
console.log('Connected successfully to server');

async function insertDocument(database, collection, document) {
  try {
    const db = client.db(dbName);
    const collection = db.collection(collectionName);
    const result = await collection.insertOne(document);
    console.log('Insert Result:', result);
  } catch (error) {
    console.error('Insert Error:', error);
  }
}

async function findDocuments(database, collection,filter) {
  try {
    const db = client.db(dbName);
    const collection = db.collection(collectionName);
    const documents = await collection.find(filter).toArray();
        return documents;
    } catch (error) {
        console.error('Find Error:', error);
    } 
}

module.exports = {
    insertDocument,
    findDocuments
}
