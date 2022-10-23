import { Injectable } from '@nestjs/common';
import { Player, Prisma } from '@prisma/client';

import { PrismaService } from 'src/prisma.service';

@Injectable()
export class PlayerService {
  constructor(private prisma: PrismaService) {}

  async create(data: Prisma.PlayerCreateInput): Promise<Player> {
    return this.prisma.player.create({
      data,
    });
  }

  async findAll(): Promise<Player[]> {
    return this.prisma.player.findMany();
  }

  async findOne(
    userWhereUniqueInput: Prisma.PlayerWhereUniqueInput,
  ): Promise<Player | null> {
    return this.prisma.player.findUnique({
      where: userWhereUniqueInput,
    });
  }

  async update(params: {
    where: Prisma.PlayerWhereUniqueInput;
    data: Prisma.PlayerUpdateInput;
  }): Promise<Player> {
    const { where, data } = params;
    return this.prisma.player.update({
      data,
      where,
    });
  }

  async remove(where: Prisma.PlayerWhereUniqueInput): Promise<Player> {
    return this.prisma.player.delete({
      where,
    });
  }
}
