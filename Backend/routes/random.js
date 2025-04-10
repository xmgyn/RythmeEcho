const { MongoClient } = require('mongodb');

const url = 'mongodb://localhost:27020';
const client = new MongoClient(url);

// Will Operate on first page, send Queue during play
function shuffle(array) {
    let currentIndex = array.length;
  
    // While there remain elements to shuffle...
    while (currentIndex != 0) {
  
      // Pick a remaining element...
      let randomIndex = Math.floor(Math.random() * currentIndex);
      currentIndex--;
  
      // And swap it with the current element.
      [array[currentIndex], array[randomIndex]] = [
        array[randomIndex], array[currentIndex]];
    }
  }

async function fetchDocument(database, collection, document) {
    try {
        await client.connect();
        const database = client.db('media_server');  // Replace with your database name
        const collection = database.collection('media_metadata');  // Replace with your collection name

        // Fetch all documents
        const data = await collection.find({}).toArray();
        shuffle(data)
        return data;
    }
    catch (error) {
        console.error('Insert Error:', error);
    } finally {
        await client.close();
    }
}

module.exports = async function (req, res) {
    const dataArray = await fetchDocument(); 
    const jsonData = JSON.stringify(dataArray);
    const uint8Array = new TextEncoder().encode(jsonData);

    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(uint8Array);
};

