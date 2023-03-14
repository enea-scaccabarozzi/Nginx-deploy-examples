import { Controller, Get, Post } from '@nestjs/common';

import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getData() {
    return this.appService.getData();
  }

  @Post('operations/long')
  async complexOperation() {
    return await this.appService.longOperation();
  }

  @Post('auth/login')
  login() {
    return this.appService.login();
  }
}
