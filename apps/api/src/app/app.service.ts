import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getData(): { message: string } {
    return { message: 'Welcome to api!' };
  }

  async longOperation(): Promise<{ result: 42 }> {
    await new Promise((r) => setTimeout(r, 5000));
    return { result: 42 };
  }

  login(): true {
    return true;
  }
}
