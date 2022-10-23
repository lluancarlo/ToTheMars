import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { Player as PlayerModel } from '@prisma/client';

import { PlayerService } from './player.service';
import { CreatePlayerDto } from './dto/create-player.dto';
import { UpdatePlayerDto } from './dto/update-player.dto';
import { Helper } from 'src/helpers/helper';

@ApiTags('player')
@Controller('player')
export class PlayerController {
  constructor(private readonly playerService: PlayerService) {}

  @Post()
  async create(@Body() createPlayerDto: CreatePlayerDto): Promise<PlayerModel> {
    return this.playerService.create({
      Name: Helper.Capitalize(createPlayerDto.Name),
      Plays: createPlayerDto.Plays,
      LastPlayed: createPlayerDto.LastPlayed,
      TopScore: createPlayerDto.TopScore,
      CreatedAt: new Date(),
      UpdatedAt: null
    });
  }

  @Get()
  async findAll(): Promise<PlayerModel[]> {
    return this.playerService.findAll();
  }

  @Get(':name')
  async findOne(@Param('name') name: string): Promise<PlayerModel> {
    return this.playerService.findOne({Name: Helper.Capitalize(name)});
  }

  @Patch(':name')
  async update(@Param('name') name: string, @Body() updatePlayerDto: UpdatePlayerDto): Promise<PlayerModel> {
    return this.playerService.update({
      where: { Name: Helper.Capitalize(name) },
      data: { 
        Plays: updatePlayerDto.Plays,
        TopScore: updatePlayerDto.TopScore,
        LastPlayed: updatePlayerDto.LastPlayed,
        UpdatedAt: new Date()  
      },
    });
  }

  @Delete(':name')
  async remove(@Param('name') name: string) {
    return this.playerService.remove({ Name: Helper.Capitalize(name) });
  }
}
