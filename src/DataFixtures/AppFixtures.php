<?php

namespace App\DataFixtures;

use App\Entity\Convention;
use App\Entity\Etudiant;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Faker\Factory;

class AppFixtures extends Fixture
{
    public function load(ObjectManager $manager)
    {
        $faker = Factory::create("fr_FR");

        for ($e = 0; $e < 15; $e++) {
            $etudiant = new Etudiant();
            $etudiant->setPrenom($faker->firstName())
                ->setNom($faker->lastName())
                ->setMail($faker->email());

            $manager->persist($etudiant);
        }

         for ($c = 0; $c < 5; $c++) {
             $convention = new Convention();
             $convention->setNbHeur($faker->numberBetween(140, 420))
                 ->setNom($faker->jobTitle());

             $manager->persist($convention);
         }

        $manager->flush();
    }
}
