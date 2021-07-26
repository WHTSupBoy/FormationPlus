<?php

namespace App\Controller;

use App\Entity\Attestation;
use App\Entity\Convention;
use App\Entity\Etudiant;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Form\FormFactoryInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;

class AttestationController extends AbstractController
{
    /**
     * @Route("/attestation", name="attestation_index")
     */
    public function index(
        EntityManagerInterface $em,
        FormFactoryInterface $factory,
        Request $request,
        UrlGeneratorInterface $urlGenerator)
    {
        $builder = $factory->createBuilder();

        $etudiant = $request->isMethod('POST')
            ? $em->getRepository(Etudiant::class)->find(
                (int)$request->request->all()['form']['etudiant']
            )
            : null;

        if ($request->isMethod('POST') && null != $etudiant) {
            $response = new Response();

            $url = $urlGenerator->generate('attestation_create', [
                'idEtudiant' => $etudiant->getId()
            ]);

            $response->headers->set('Location', $url);
            $response->setStatusCode(302);

            return $response;
        }

        $builder->add("etudiant", EntityType::class, [
            "label" => "Liste des étudiants",
            "attr" => ["class" => "form-control form-select form-select-sm"],
            "placeholder" => "Sélectionner un étudiant",
            "class" => Etudiant::class,
            "choice_label" => "nom"
        ]);

        $form = $builder->getForm();

        $formView = $form->createView();

        return $this->render("attestation/index.html.twig", [
            "formView" => $formView,
            "etudiant" => $etudiant
        ]);
    }

    /**
     * @Route("/attestation/create/{idEtudiant<\d+>?0}", methods={"GET","HEAD", "POST"}, name="attestation_create")
     */
    public function create(int $idEtudiant, FormFactoryInterface $factory, EntityManagerInterface $em, Request $request)
    {

        $builder = $factory->createBuilder();

        $etudiant = 0 != $idEtudiant
            ? $em->getRepository(Etudiant::class)->find($idEtudiant)
            : null;

        $builder->add("etudiant", EntityType::class, [
            "label" => "Liste des étudiants",
            "attr" => [
                "class" => "form-control form-select form-select-sm",
                "onChange" => "redirectOnStudentChange()"
            ],
            "placeholder" => "Sélectionner un étudiant",
            "class" => Etudiant::class,
            "choice_label" => "nom",
            "data" => $etudiant ?? null
        ])
            ->add("convention", EntityType::class, [
            "label" => "Convention",
            "attr" => ["class" => "form-control form-select-sm"],
            "class" => Convention::class,
            "disabled" => true,
            "data" => $etudiant ? $etudiant->getConvention() : null
        ]);

        $form = $builder->getForm();

        $form->handleRequest($request);
        
        $data = $form->getData();

        if ($form->isSubmitted()) {
            $data = $form->getData();

            $attestation = new Attestation();
            $attestation->setMessage($data["message"])
                ->setEtudiant($data["etudiant"])
                ->setConvention($data["convention"]);

        }

        $formView = $form->createView();

        return $this->render("attestation/create.html.twig", [
            "formView" => $formView,
            "etudiant" => $etudiant
        ]);
    }
}
