import { Module } from '@nestjs/common';
import { PlayerModule } from './player/player.module';

@Module({
  imports: [PlayerModule],
  controllers: [],
  providers: [],
})
export class AppModule {}
