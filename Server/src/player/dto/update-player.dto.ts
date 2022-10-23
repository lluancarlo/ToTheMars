import { PartialType } from '@nestjs/mapped-types';
import { ApiProperty } from '@nestjs/swagger';

import { CreatePlayerDto } from './create-player.dto';

export class UpdatePlayerDto extends PartialType(CreatePlayerDto) {
    @ApiProperty()
    LastPlayed: Date;
    
    @ApiProperty()
    TopScore: number;
    
    @ApiProperty()
    Plays: number;
}
