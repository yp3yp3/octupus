const express = require('express');
const { MongoClient } = require('mongodb');

const app = express();
const port = 3000;

// קישור למסד הנתונים MongoDB
const uri = 'mongodb://mymongoDB:27017';
const client = new MongoClient(uri);

async function getApplesCount() {
    try {
        await client.connect();
        const database = client.db('mydatabase');
        const collection = database.collection('mycollection');

        // שימוש ב-aggregate כדי לסכום את מספר התפוחים
        const result = await collection.aggregate([
            { $match: { name: 'apples' } },  // מסנן מסמכים שבהם השם הוא "apples"
            { $group: { _id: null, total: { $sum: "$qty" } } }  // מסכם את השדה "qty"
        ]).toArray();

        if (result.length > 0) {
            return result[0].total;  // החזרת סכום התפוחים
        } else {
            return 0;  // אם לא נמצאו מסמכים
        }
    } finally {
        await client.close();
    }
}

app.get('/', async (req, res) => {
    const applesCount = await getApplesCount();
    res.send(`<h1>Hello World</h1><p>Number of apples: ${applesCount}</p>`);
});

app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});
