-- CreateTable
CREATE TABLE "Player" (
    "Name" TEXT NOT NULL PRIMARY KEY,
    "LastPlayed" DATETIME,
    "TopScore" INTEGER NOT NULL DEFAULT 0,
    "Plays" INTEGER NOT NULL DEFAULT 0,
    "CreatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "UpdatedAt" DATETIME
);

-- CreateIndex
CREATE UNIQUE INDEX "Player_Name_key" ON "Player"("Name");
