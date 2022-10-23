import { ApiProperty } from "@nestjs/swagger";

export class CreatePlayerDto {
    @ApiProperty()
    Name: string;

    @ApiProperty()
    LastPlayed: Date;

    @ApiProperty()
    TopScore: number;
    
    @ApiProperty()
    Plays: number;
}
